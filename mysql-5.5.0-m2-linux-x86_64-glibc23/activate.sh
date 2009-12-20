#!/bin/sh

sudo ln -s $PREFIX/mysql-5.5.0-m2-linux-x86_64-glibc23 /usr/local/mysql
sudo mkdir /var/run/mysqld/
sudo chown mysql:mysql /var/run/mysqld
for x in mysql mysqladmin; do
    sudo ln -s $PREFIX/mysql-5.5.0-m2-linux-x86_64-glibc23/bin/$x /usr/local/bin/$x
done
