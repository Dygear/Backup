#!/bin/bash

# Update & Upgrade Server, plus install all dependencies.
apt -y update
apt -y upgrade
apt -y install pkg-config openssl libssl-dev libxml2-dev libonig-dev sqlite3 libsqlite3-dev libcurl4-openssl-dev zlib1g-dev libpng-dev autoconf bison re2c

# Go Home
cd ~

# Install PHP
wget https://php.net/distributions/php-8.1.0RC6.tar.xz
tar xf php-8.1.0RC6.tar.xz
cd php-8.1.0RC6
./configure --enable-fpm --enable-pcntl --enable-calendar --enable-mbstring --with-zlib --with-openssl --with-libxml --enable-soap
make -j`nproc`
make TEST_PHP_ARGS=-j`nproc` test
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
