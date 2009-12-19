#!/bin/zsh
export VERSION=0.8.30

sudo mkdir /var/log/nginx

sudo ln -s /usr/local/app/nginx-$VERSION /usr/local/app/nginx
sudo ln -s ../app/nginx/sbin/nginx /usr/local/app/nginx/sbin/nginx

