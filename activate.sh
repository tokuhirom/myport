#!/bin/zsh

if [ $# = 0 ];then
    echo "Usage: $0 pkgname";
    exit
fi

PKGNAME=$1
if [ ! -d $PKGNAME ];then
    echo "$PKGNAME does not exists"
    exit
fi

export PREFIX=/usr/local/app/

cd packages/$PKGNAME
exec ./activate.sh
