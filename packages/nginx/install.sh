#!/bin/zsh
export VERSION=0.8.30

if [ -f /etc/debian_version ]; then
    sudo aptitude -y install libpcre3-dev libssl-dev
fi

if [ ! -f nginx-$VERSION.tar.gz ]; then
    wget http://sysoev.ru/nginx/nginx-$VERSION.tar.gz
fi
tar xzvf nginx-$VERSION.tar.gz
cd nginx-$VERSION
./configure --prefix=/usr/local/app/nginx-$VERSION
make
make install

