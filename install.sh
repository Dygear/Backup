#!/bin/bash
#chmod u+x install.sh

apt-get install build-essential libgd2-xpm-dev libgeoip-dev libpcre3-dev libssl-dev curl libcurl3 libcurl3-dev libmcrypt-dev libxslt-dev libxml2-dev sendmail

cd ~

wget http://nginx.org/download/nginx-1.9.3.tar.gz
tar xvfz nginx-1.9.3.tar.gz
cd nginx-1.9.3
./configure --prefix=/usr/local/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --lock-path=/var/lock/nginx.lock --pid-path=/var/run/nginx.pid --with-pcre-jit --with-debug --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_realip_module --with-http_stub_status_module --with-http_ssl_module --with-http_sub_module --with-http_xslt_module --with-ipv6 --with-sha1=/usr/include/openssl --with-md5=/usr/include/openssl --with-mail --with-mail_ssl_module
make
make install
mkdir /var/lib/nginx
mkdir /var/lib/nginx/body

cd ~

wget https://downloads.php.net/~ab/php-7.0.0beta3.tar.gz
tar xvfz php-7.0.0beta3.tar.gz
cd php-7.0.0beta3
./configure --enable-fpm --with-mcrypt --with-zlib --enable-mbstring --with-openssl --with-gd --with-jpeg-dir=/usr/lib --with-png-dir=/usr/lib --enable-gd-native-ttf --with-curl --enable-ftp --enable-calendar --enable-pcntl --enable-soap
make
make test
make install

cd ~

curl -L https://ghost.org/zip/ghost-latest.zip -o ghost.zip
unzip -uo ghost.zip -d /www/ems/ghost/
cd /www/ems/ghost/
curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -
apt-get install -y nodejs

cd ~
