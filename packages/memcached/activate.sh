#!/bin/zsh

. ./VERSION

sudo ln -s $PREFIX/memcached-$VERSION $PREFIX/memcached
sudo ln -s $PREFIX/memcached/bin/memcached $PREFIX/../bin/memcached
