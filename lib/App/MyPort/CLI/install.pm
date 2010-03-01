package App::MyPort::CLI::install;
use strict;
use warnings;
use App::MyPort::CLI -command;
use App::MyPort::Installer;
use File::Spec::Functions;

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

    my ($pkg, @args) = @$args;
    $self->_install($pkg, @args);
}

sub _install {
    my ($self, $pkg, @args) = @_;

    my $context = App::MyPort::Installer->load($pkg);
    $context->install(@args);
}

1;
__END__

=head1 SYNOPSIS

    % myport install nginx

