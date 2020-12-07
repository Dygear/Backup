#!/bin/bash

# Update & Upgrade Server, plus install all dependencies.
# apt -y update
# apt -y upgrade
apt -y install openssl libssl-dev libxml2-dev libonig-dev sqlite3 libsqlite3-dev libcurl4-openssl-dev

# Go Home
cd ~

# Install nginx
wget https://nginx.org/download/nginx-1.19.4.tar.gz
tar xf nginx-1.19.4.tar.gz
cd nginx-1.19.4
./configure --enable-fpm --with-zlib --enable-mbstring --with-openssl --enable-calendar --enable-pcntl --enable-soap --enable-debug --enable-opcache
make -j `nproc`
make install
mkdir -p /var/lib/nginx

# Install init.d script

# Go Home
cd ~

# Install PHP
wget https://php.net/distributions/php-8.0.0.tar.xz
tar xf php-8.0.0.tar.xz
cd php-8.0.0
./configure --enable-fpm --enable-pcntl --enable-calendar --enable-mbstring --with-zlib --with-openssl --with-libxml --enable-soap
make -j`nproc`
#make test
make install

# Install init.d script
cp ./sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod u+x /etc/init.d/php-fpm
update-rc.d php-fpm defaults

# Install Config Files
cp ./sapi/fpm/php-fpm.conf /usr/local/etc/php-fpm.conf
mkdir -p /usr/local/NONE/etc/php-fpm.d/
cp ./sapi/fpm/www.conf /usr/local/NONE/etc/php-fpm.d/www.conf
nano /usr/local/NONE/etc/php-fpm.d/www.conf

cd ~
