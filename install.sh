#!/bin/zsh

if [ $# == 0 ];then
    echo "Usage: install.sh pkgname";
    exit
fi

PKGNAME=$1
export PREFIX=/usr/local/app/

function install_autotools () {
    if [ ! -f $TARFILE ]; then
        wget $SRCURL
    fi

    tar xzvf $TARFILE
    cd $TARDIR
    ./configure --prefix=/usr/local/app/$APP-$VERSION
    make
    make install
}

if [ ! -d $PREFIX ]; then
    mkdir $PREFIX
fi

if [ ! -d $PKGNAME ];then
    echo "$PKGNAME does not exists"
    exit
fi

if [ -f $PKGNAME/SPEC ]; then
    echo "loading spec"
    . $PKGNAME/SPEC
fi
echo "installing $PKGNAME"
if [ ! -d $PKGNAME/build ]; then
    mkdir -p $PKGNAME/build
fi
cd $PKGNAME/build/
if [ -f ../install.sh ]; then
    . ../install.sh
else
    install_autotools
fi
