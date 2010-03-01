package App::MyPort::CLI::activate;
use strict;
use warnings;
use App::MyPort::CLI -command;
use File::Spec::Functions qw/catdir/;
use App::MyPort::Installer;

our $VERSION;

sub run {
    my ( $self, $opt, $args ) = @_;

    my ($pkg) = @$args;
    my $installer = App::MyPort::Installer->load($pkg);
    $installer->activate();
}

1;
