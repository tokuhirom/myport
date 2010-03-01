package App::MyPort::Installer;
use strict;
use warnings;
use parent qw/Class::Accessor::Fast/;
use autodie;
use LWP::UserAgent;
use Archive::Extract;
use URI;
use File::Basename qw/basename/;
use Path::Class;
use File::Spec::Functions qw/catfile catdir/;
use App::MyPort::Util;

__PACKAGE__->mk_accessors(qw/install_hook pre_hook post_hook url version archive pkg/);

our $VERSION;
our $ARCHIVEFILE;
our $URL;
our $PRE_HOOK;
our $POST_HOOK;
our $INSTALL_HOOK;

my $ua = LWP::UserAgent->new( agent => "myport/$App::MyPort::VERSION" );

sub load {
    my ($class, $pkg) = @_;
    my $specdir = App::MyPort->get_spec_dir();
    my $specpath = catdir($specdir, $pkg, 'SPEC');
    unless (-f $specpath) {
        die "package '$pkg' not found: $specpath\n";
    }
    do $specpath;
    $ARCHIVEFILE ||= basename(URI->new($URL)->path) || 'tmp.tar.gz';

    return bless {
        version      => $VERSION,
        url          => $URL,
        archive      => $ARCHIVEFILE,
        pkg          => $pkg,
        pre_hook     => $PRE_HOOK,
        post_hook    => $POST_HOOK,
        install_hook => $INSTALL_HOOK,
    }, $class;
}

sub install {
    my ($self, @args) = @_;
    chdir(App::MyPort->get_build_dir()) or die "cannot chdir: $!";

    # before
    if (my $code = $self->pre_hook) {
        $code->();
    }

    diag "fetch archive";
    $ua->mirror($self->url, $self->archive);

    diag "extract archive";
    my $archive = Archive::Extract->new( archive => $self->archive )
        or die "Cannot extract archive: @{[ $self->archive ]}";
    $archive->extract();

    my @children = grep { basename($_) ne $self->archive }
                        dir('.')->children();
    if (@children == 1) {
        chdir($children[0]) or die "cannot chdir: $!";
    }

    # install
    if ($self->install_hook) {
        diag "install by custom hook";
        $self->install_hook->($self->prefix, @args);
    } elsif (-f 'configure') {
        $self->_install_configure(@args);
    } else {
        die "unknown installation type for @{[ $self->url ]}";
    }

    # after
    if (my $code = $self->post_hook) {
        $code->();
    }
}

sub prefix {
    my ($self, ) = @_;
    catdir(App::MyPort->rootdir, $self->pkg . '-' . $self->version);
}

sub _install_configure {
    my ($self, @args) = @_;
    my $prefix = $self->prefix;
    run_cmd('./configure', "--prefix=$prefix", @args);
    run_cmd('make');
    run_cmd('make', 'install');
}

sub activate {
    my ($self) = @_;
    my $origin = catdir(App::MyPort->rootdir, $self->pkg . '-' . $self->version);
    my $relay  = catdir(App::MyPort->rootdir, $self->pkg);
    unless (-d $origin) {
        die "@{[ $self->pkg ]}-@{[ $self->version ]} is not installed";
    }
    if (-l $relay) { # -l : is symbolic link
        unlink($relay) or die "cannot unlink: $relay";
    }
    symlink($origin => $relay) or die "cannot symlink: '$origin' to '$relay'";

    my $local_dir = App::MyPort->local_dir;
    for my $target (qw(lib bin include")) {
        my $cdir = dir($relay, $target);
        if (-d $cdir) {
            for my $file ($cdir->children) {
                my $src = $file->absolute();
                my $dst = catdir($local_dir, $target, basename($file));
                if (-l $dst) {
                    unlink($dst);
                }
                diag "ln -s $src $dst";
                symlink($src, $dst) or die "cannot symlink $file: $!";
            }
        }
    }

    if (-d catdir($origin, 'lib') && $^O eq 'linux') {
        run_cmd('/sbin/ldconfig');
    }
}

1;
