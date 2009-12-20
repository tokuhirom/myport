#!/bin/sh

if [ ! -f mysql-5.5.0-m2-linux-x86_64-glibc23.tar.gz ]; then
    wget http://dev.mysql.com/get/Downloads/MySQL-5.5/mysql-5.5.0-m2-linux-x86_64-glibc23.tar.gz/from/http://ftp.iij.ad.jp/pub/db/mysql/
fi

sudo groupadd mysql
sudo useradd -g mysql mysql
tar xzvf mysql-5.5.0-m2-linux-x86_64-glibc23.tar.gz -C $PREFIX/
cd $PREFIX/mysql-5.5.0-m2-linux-x86_64-glibc23
sudo chown -R mysql .
sudo chgrp -R mysql .
sudo scripts/mysql_install_db --user=mysql --basedir=.
sudo chown -R root .
sudo chown -R mysql data
