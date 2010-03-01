package App::MyPort::CLI::activate;
use strict;
use warnings;
use App::MyPort::CLI -command;
use App::MyPort::Installer;

sub run {
    my ( $self, $opt, $args ) = @_;

    my ($pkg) = @$args;
    my $installer = App::MyPort::Installer->load($pkg);
    $installer->activate();
}

1;
__END__

=head1 NAME

App::MyPort::CLI::activate - activate application

=head1 SYNOPSIS

    % myport activate nginx

=head1 DESCRIPTION

activate application

=head1 AUTHORS

Tokuhiro Matsuno

