#!/bin/sh

if [ $# == 0 ];then
    echo "Usage: $0 pkgname";
    exit
fi

PKGNAME=$1
echo "uninstalling $PKGNAME"
cd $PKGNAME/
./uninstall.sh

