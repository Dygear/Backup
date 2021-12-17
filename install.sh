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
wget https://www.php.net/distributions/php-8.1.0.tar.xz
tar xf php-8.1.0.tar.xz
cd php-8.1.0
./configure --enable-fpm --enable-pcntl --enable-calendar --enable-mbstring --with-zlib --with-openssl --with-libxml --enable-soap
make -j`nproc`
make TEST_PHP_ARGS=-j`nproc` test
make install

# Install service file.
mv /usr/local/etc/php-fpm.conf.default /usr/local/etc/php-fpm.conf
## Moify /usr/local/etc/php-fpm.conf
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

cp ./sapi/fpm/php-fpm.service /etc/systemd/system/
## Change `ProtectSystem=true` to `ProtectSystem=false`.
systemctl enable php-fpm.service
