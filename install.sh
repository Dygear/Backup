#!/bin/bash

# Install Ghost Blogging Platform (And it's dependencies)
mkdir -p /www/ems/ghost/
curl -L https://ghost.org/zip/ghost-latest.zip -o ghost.zip
unzip -uo ghost.zip -d /www/ems/ghost/
cd /www/ems/ghost/
curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -
apt-get install -y nodejs

# Update & Upgrade Server, plus install all dependencies.
# apt-get -y update
# apt-get -y upgrade
apt-get -y install build-essential libgd2-xpm-dev libgeoip-dev libpcre3-dev libssl-dev curl libcurl3 libcurl3-dev libmcrypt-dev libxslt-dev libxml2-dev sendmail

# Go Home
cd ~

# Install nginx
wget http://nginx.org/download/nginx-1.10.0.tar.gz
tar xf nginx-1.10.0.tar.gz
cd nginx-1.10.0
./configure --prefix=/usr/local/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --lock-path=/var/lock/nginx.lock --pid-path=/var/run/nginx.pid --with-pcre-jit --with-debug --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_realip_module --with-http_stub_status_module --with-http_ssl_module --with-http_sub_module --with-http_xslt_module --with-ipv6 --with-sha1=/usr/include/openssl --with-md5=/usr/include/openssl --with-mail --with-mail_ssl_module --with-http_v2_module
make
make install
mkdir -p /var/lib/nginx

# Install init.d script


# Go Home
cd ~

# Install PHP
wget http://php.net/distributions/php-7.0.6.tar.xz
tar xf php-7.0.6.tar.xz
cd php-7.0.6
./configure --enable-fpm --with-mcrypt --with-zlib --enable-mbstring --with-openssl --with-gd --with-jpeg-dir=/usr/lib --with-png-dir=/usr/lib --enable-gd-native-ttf --with-curl --enable-ftp --enable-calendar --enable-pcntl --enable-soap --enable-debug --enable-opcache --enable-opcache-file
make
# make test
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
