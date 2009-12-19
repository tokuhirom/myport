#!/bin/sh
if [ -h $PREFIX/perl ]; then
    rm $PREFIX/perl
fi
ln -s $PREFIX/perl-5.10.1 $PREFIX/perl
for x in perl perldoc cpan; do
    DST=$PREFIX/../bin/$x
    if [ -h $DST ]; then
        sudo rm $DST
    fi
    sudo ln -s $PREFIX/perl/bin/$x $DST
done

