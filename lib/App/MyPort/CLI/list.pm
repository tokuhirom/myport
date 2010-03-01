package App::MyPort::CLI::list;
use strict;
use warnings;
use App::MyPort::CLI -command;
use Path::Class;
use File::Basename;

sub opt_spec {
    return (
#       [ "blortex|X", "use the blortex algorithm" ],
#       [ "recheck|r", "recheck all results" ],
    );
}

sub validate_args {
    my ( $self, $opt, $args ) = @_;
}

sub run {
    my ( $self, $opt, $args ) = @_;

    for my $d (dir(App::MyPort->get_spec_dir())->children) {
        my $basename = basename($d);
        next if $basename =~ /^\./;
        print "$basename\n";
    }
}

1;
