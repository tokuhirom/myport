#!/bin/sh

if [ $# == 0 ];then
    echo "Usage: install.sh pkgname";
    exit
fi

PKGNAME=$1
export PREFIX=/usr/local/app/

if [ ! -d $PREFIX ]; then
    mkdir $PREFIX
fi

if [ ! -d $PKGNAME ];then
    echo "$PKGNAME does not exists"
    exit
fi

echo "installing $PKGNAME"
if [ ! -d $PKGNAME/build ]; then
    mkdir $PKGNAME/build
fi
cd $PKGNAME/build/
exec ../install.sh

