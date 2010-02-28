#!/bin/zsh

if [ $# = 0 ];then
    echo "Usage: $0 pkgname";
    exit
fi

function link_files () {
    TARGET=$1
    echo "linking $TARGET"
    if [ -d $PREFIX/$APP/$TARGET ]; then
        for src in $PREFIX/$APP/$TARGET/*; do
            echo sudo ln -s $src /usr/local/$TARGET/${src##$PREFIX/$APP/$TARGET/}
            sudo ln -s $src /usr/local/$TARGET/${src##$PREFIX/$APP/$TARGET/}
        done
    fi
}
function link_libs     () { link_files "lib"     }
function link_bins     () { link_files "bin"     }
function link_includes () { link_files "include" }

PKGNAME=$1
if [ ! -d $PKGNAME ];then
    echo "$PKGNAME does not exists"
    exit
fi

export PREFIX=/usr/local/app/

if [ -f $PKGNAME/SPEC ]; then
    echo "loading spec"
    . $PKGNAME/SPEC
fi

if [ -e $PREFIX/$APP ]; then
    rm $PREFIX/$APP
fi
rm $PREFIX/$APP
ln -s $PREFIX/$APP-$VERSION $PREFIX/$APP

if [ -e $PKGNAME/activate.sh ];then
    . $PKGNAME/activate.sh
else
    link_libs
    link_bins
    link_includes
fi

if [ -d $PREFIX/$APP/lib/ ]; then
    sudo /sbin/ldconfig
fi
