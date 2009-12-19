#!/bin/sh
. ../VERSION

if [ -f /etc/debian_version ]; then
    sudo aptitude install libevent-dev
fi

if [ ! -f memcached-$VERSION.tar.gz ]; then
    wget http://memcached.googlecode.com/files/memcached-1.4.4.tar.gz
fi
tar xzvf memcached-$VERSION.tar.gz
cd memcached-$VERSION/
./configure --prefix=$PREFIX/memcached-$VERSION
make
make install

