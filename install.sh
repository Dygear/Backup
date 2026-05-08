#!/bin/bash

## This file now assumes a debian 13 (Trixie) install.
## Must be ran as root or via sudo (after you installed sudo).

# Update & Upgrade Server, plus install all dependencies.
apt -y update
apt -y upgrade
apt -y install git nginx build-essential pkg-config openssl libssl-dev libxml2-dev libonig-dev sqlite3 libsqlite3-dev libcurl4-openssl-dev zlib1g-dev libpng-dev autoconf bison re2c libsodium-dev

# Go Home
cd ~

# Build SQLite 3.53.1 + SEE
# First: scp sqlite_encryption_extension-20251128184002-e61aa9c5b3.tar.gz to /root/ on the server.

set -e

SQLITE_VER=3530100

SEE_NAME=sqlite_encryption_extension-20260505113605-befcb56c30
SEE_TAR=${SEE_NAME}.tar.gz
SEE_DIR=../${SEE_NAME}

mkdir -p ~/build/sqlite-see
cd ~/build/sqlite-see

wget https://sqlite.org/2026/sqlite-autoconf-${SQLITE_VER}.tar.gz

tar xf sqlite-autoconf-${SQLITE_VER}.tar.gz
tar xf ~/${SEE_TAR}

cd sqlite-autoconf-${SQLITE_VER}

make distclean || true

# Replace public SQLite amalgamation with SEE-enabled amalgamation.
cp "${SEE_DIR}/sqlite3-see.c" ./sqlite3.c

# Use SEE's enhanced CLI shell and matching header.
cp "${SEE_DIR}/shell.c" ./shell.c
cp "${SEE_DIR}/sqlite3.h" ./sqlite3.h

./configure --enable-fts5 --enable-rtree --enable-geopoly --enable-dbpage --enable-dbstat
make -j"$(nproc)"
sudo make install
sudo ldconfig

sqlite3 --version

# Install PHP
cd ~/build/
wget https://www.php.net/distributions/php-8.5.6.tar.xz
tar xf php-8.5.6.tar.xz
cd php-8.5.6
./configure --enable-fpm --enable-pcntl --enable-calendar --enable-mbstring --with-zlib --with-openssl --with-libxml --enable-soap --with-sodium
make -j`nproc`
make TEST_PHP_ARGS=-j`nproc` test
make install

# Install service file.
mv /usr/local/etc/php-fpm.conf.default /usr/local/etc/php-fpm.conf
## Modify /usr/local/etc/php-fpm.conf
##  ;pid = run/php-fpm.pid
## to say
##  pid = /run/php-fpm.pid
## And:
##  ;error_log = log/php-fpm.log
## to say
##  error_log = /var/www/php-fpm.log
## and the last line remove the `NONE/`
##  include=NONE/etc/php-fpm.d/*.conf
## should just be
##  include=etc/php-fpm.d/*.conf

mv /usr/local/etc/php-fpm.d/www.conf.default /usr/local/etc/php-fpm.d/www.conf
## Modify the following lines in
## /usr/local/etc/php-fpm.d/www.conf
##  ;prefix = /path/to/pools/$pool
## to say
##  /var/$pool
## And:
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
