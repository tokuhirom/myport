#!/bin/zsh
if [ ! -d bigram ];then
    svn co http://mysqlftppc.svn.sourceforge.net/svnroot/mysqlftppc/bigram/trunk/ bigram
fi
cd bigram
aclocal
libtoolize --automake
automake --add-missing
automake
autoconf
./configure \
    --with-mysql-config=/usr/local/mysql/bin/mysql_config
make
make install
