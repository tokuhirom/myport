#!/bin/zsh

. ../VERSION

if [ -f /etc/debian_version ]; then
    sudo aptitude install libbz2-dev
fi

if [ ! -f tokyocabinet-$VERSION.tar.gz ]; then
    wget http://1978th.net/tokyocabinet/tokyocabinet-$VERSION.tar.gz
fi

tar xzvf tokyocabinet-$VERSION.tar.gz
cd tokyocabinet-$VERSION
./configure --prefix=/usr/local/app/tokyocabinet-$VERSION
make
make install

