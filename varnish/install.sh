#!/bin/zsh
. ../VERSION

TARFILE=varnish-$VERSION.tar.gz
SRCURL=http://downloads.sourceforge.net/project/varnish/varnish/$VERSION/$TARFILE
TARDIR=varnish-$VERSION
APP=varnish

#   if [ -f /etc/debian_version ]; then
#       sudo aptitude install libbz2-dev
#   fi

if [ ! -f $TARFILE ]; then
    wget $SRCURL
fi

tar xzvf $TARFILE
cd $TARDIR
./configure --prefix=/usr/local/app/$APP-$VERSION
make
make install

