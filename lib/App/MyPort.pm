package App::MyPort;
use strict;
use warnings;
use 5.00800;
our $VERSION;
BEGIN { $VERSION = '0.01' };
use IO::Prompt;
use File::Path qw/mkpath/;
use File::HomeDir;
use File::Spec::Functions qw/catfile/;

our $ROOTDIR = $ENV{MYPORT_ROOT} || '/usr/local/app/';
our $GITREPO = $ENV{MYPORT_SPEC_GITREPO} || 'git://github.com/tokuhirom/myport-spec.git';
our $LOCALDIR = $ENV{MYPORT_LOCALDIR} || '/usr/local/';

# bootstrap code.
unless (-d $ROOTDIR) {
    if (prompt("Would you create dest dir '$ROOTDIR'?", '-y')) {
        mkpath($ROOTDIR) or die "Cannot create '$ROOTDIR': $!";
    }
}

sub local_dir { $LOCALDIR }
sub rootdir { $ROOTDIR }
sub get_build_dir {
    my $home = File::HomeDir->my_home;
    for my $t (0..1000) {
        my $dir = catfile($home, ".myport", "build", "build-" . (time()+$t));
        next if -d $dir;
        mkpath($dir) or die "Cannot create '$dir': $!";
        return $dir;
    }
    die "fatal error: cannot get build dir";
}
sub get_dotdir {
    my $home = File::HomeDir->my_home;
    my $dir = catfile($home, '.myport');
    unless (-d $dir) {
        mkpath($dir) or die "cannot create '$dir': $!";
    }
    $dir;
}
sub get_spec_dir {
    my $dotdir = get_dotdir();
    my $specdir = catfile($dotdir, 'spec');
    unless (-d $specdir) {
        system("git", "clone", $GITREPO, $specdir) == 0
            or die "Cannot clone $GITREPO to $specdir";
    }
    return $specdir;
}

1;
