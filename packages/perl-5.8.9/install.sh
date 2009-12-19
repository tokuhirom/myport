#!/bin/zsh
VERSION=5.8.9

if [ -f /etc/debian_version ]; then
    sudo aptitude build-dep perl
fi

# clean up
rm -rf perl-$VERSION/

# get
if [ ! -f perl-$VERSION.tar.gz ];then
    wget http://search.cpan.org/CPAN/authors/id/N/NW/NWCLARK/perl-$VERSION.tar.gz
fi

# extract
tar xzvf perl-$VERSION.tar.gz
cd perl-$VERSION

# configure
./Configure -d -DDEBUGGING -Dprefix=/usr/local/app/perl-$VERSION/ -Duse64bitint

# make & install
make
make install

