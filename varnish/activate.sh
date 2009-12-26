#!/bin/zsh
. ./VERSION

APPLICATION=varnish
sudo ln -s /usr/local/app/$APPLICATION-$VERSION /usr/local/app/$APPLICATION

