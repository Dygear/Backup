#!/bin/bash

## This file now assumes a debian 11 (bullseye) install.
## Must be ran as root.

# Update & Upgrade Server, plus install all dependencies.
apt -y update
apt -y upgrade
apt -y install nginx build-essential pkg-config openssl libssl-dev libxml2-dev libonig-dev sqlite3 libsqlite3-dev libcurl4-openssl-dev zlib1g-dev libpng-dev autoconf bison re2c

# Go Home
cd ~

# Install PHP
wget https://www.php.net/distributions/php-8.1.5.tar.xz
tar xf php-8.1.5.tar.xz
cd php-8.1.5
./configure --enable-fpm --enable-pcntl --enable-calendar --enable-mbstring --with-zlib --with-openssl --with-libxml --enable-soap
make -j`nproc`
make TEST_PHP_ARGS=-j`nproc` test
make install

# Install service file.
mv /usr/local/etc/php-fpm.conf.default /usr/local/etc/php-fpm.conf
## Modify /usr/local/etc/php-fpm.conf
## the last line to remove the `NONE/`
## should just be `include=etc/php-fpm.d/*.conf`

mv /usr/local/etc/php-fpm.d/www.conf.default /usr/local/etc/php-fpm.d/www.conf
## Modify the following lines in
## /usr/local/etc/php-fpm.d/www.conf
##  user = nobody
##  group = nobody
## to say
##  user = www-data
##  group = www-data
## And:
##  listen = 127.0.0.1:9000
## to say
##  listen = /run/php-fpm.sock
## And:
##  ;listen.owner = nobody
##  ;listen.group = nobody
##  ;listen.mode = 0660
## to say
##  listen.owner = www-data
##  listen.group = www-data
##  listen.mode = 0660
## And:
##  pm = dynamic
## to say
##  pm = static
## And:
##  pm.max_children = 5
## to say
##  pm.max_children = 16 (Or number of CPU Cores)

cp ./sapi/fpm/php-fpm.service /etc/systemd/system/
## Change `ProtectSystem=true` to `ProtectSystem=false`.
systemctl enable php-fpm.service
