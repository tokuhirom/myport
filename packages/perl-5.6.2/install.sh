#!/bin/zsh

if [ -f /etc/debian_version ]; then
    sudo aptitude build-dep perl
fi

# get
if [ ! -f perl-5.6.2.tar.gz ];then
    wget http://search.cpan.org/CPAN/authors/id/R/RG/RGARCIA/perl-5.6.2.tar.gz
fi

# extract
tar xzvf perl-5.6.2.tar.gz
cd perl-5.6.2

# apply patches
patch -p0 < ../../patches/ipc-sysv-no-asm-page-h.diff
patch -p0 < ../../patches/makedepend-SH.diff

# configure
./configure.gnu -d -DDEBUGGING --prefix=/usr/local/app/perl-5.6.2/

# make & install
make
make install

