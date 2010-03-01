package App::MyPort::CLI::list;
use strict;
use warnings;
use App::MyPort::CLI -command;
use Path::Class;
use File::Basename;

sub run {
    my ( $self, $opt, $args ) = @_;

    for my $d (dir(App::MyPort->get_spec_dir())->children) {
        my $basename = basename($d);
        next if $basename =~ /^\./;
        print "$basename\n";
    }
}

1;
__END__

=head1 NAME

App::MyPort::CLI::list - list of myports

=head1 SYNOPSIS

    % myport list

=head1 DESCRIPTION

This command prints list of myports.

=head1 AUTHORS

Tokuhiro Matsuno

