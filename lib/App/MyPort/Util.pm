package App::MyPort::Util;
use strict;
use warnings;
use base qw/Exporter/;
our @EXPORT = qw/run_cmd diag/;

sub diag { print("@_\n") if $ENV{MYPORT_VERBOSE} }

sub run_cmd {
    diag("@_");
    system(@_) == 0 or die "execution failed: '@_'";
}

1;
