FROM alpine:3.5
MAINTAINER Arvind Rawat <arvindr226@gmail.com>

RUN apk add --update --no-cache bash \
				curl \
				curl-dev \
				php7-intl \
				php7-openssl \
				php7-dba \
				php7-sqlite3 \
				php7-pear \
				php7-phpdbg \
				php7-litespeed \
				php7-gmp \
				php7-pdo_mysql \
				php7-pcntl \
				php7-common \
				php7-xsl \
				php7-fpm \	
				php7-mysqlnd \
				php7-enchant \
				php7-pspell \
				php7-snmp \
				php7-doc \
				php7-mbstring \
				php7-dev \
				php7-xmlrpc \
				php7-embed \
				php7-xmlreader \
				php7-pdo_sqlite \
				php7-exif \
				php7-opcache \
				php7-ldap \
				php7-posix \	
				php7-session \
				php7-gd  \
				php7-gettext \
				php7-json \
				php7-xml \
				php7 \
				php7-iconv \
				php7-sysvshm \
				php7-curl \
				php7-shmop \
				php7-odbc \
				php7-phar \
				php7-pdo_pgsql \
				php7-imap \
				php7-pdo_dblib \
				php7-pgsql \
				php7-pdo_odbc \
				php7-xdebug \
				php7-zip \
				php7-apache2 \
				php7-cgi \
				php7-ctype \
				php7-mcrypt \
				php7-wddx \
				php7-bcmath \
				php7-calendar \
				php7-tidy \
				php7-dom \
				php7-sockets \
				php7-soap \
				php7-apcu \
				php7-sysvmsg \
				php7-zlib \
				php7-ftp \
				php7-sysvsem \ 
				php7-pdo \
				php7-bz2 \
				php7-mysqli \
  				apache2 \
				libxml2-dev \
				apache2-utils

RUN	mkdir /var/www/html/ && chown -R apache.www-data /var/www/html/ && \
   
    sed -i 's#^DocumentRoot ".*#DocumentRoot /var/www/html #g' /etc/apache2/httpd.conf && \
    sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf && \
    sed -i 's#^ServerRoot .*#ServerRoot /web#g'  /etc/apache2/httpd.conf && \
    sed -i 's/^#ServerName.*/ServerName webproxy/' /etc/apache2/httpd.conf && \
    sed -i 's#^IncludeOptional /etc/apache2/conf#IncludeOptional /web/config/conf#g' /etc/apache2/httpd.conf && \
    sed -i 's#PidFile "/run/.*#Pidfile "/web/run/httpd.pid"#g'  /etc/apache2/conf.d/mpm.conf && \
    sed -i 's#Directory "/var/www/localhost/htdocs.*#Directory "/var/www/html/" >#g' /etc/apache2/httpd.conf && \
    sed -i 's#Directory "/var/www/localhost/cgi-bin.*#Directory "/var/www/" >#g' /etc/apache2/httpd.conf && \

    sed -i 's#/var/log/apache2/#/var/www/#g' /etc/logrotate.d/apache2 && \
    sed -i 's/Options Indexes/Options /g' /etc/apache2/httpd.conf 

RUN ln -s /usr/bin/php7 /usr/bin/php
RUN curl -sS https://getcomposer.org/installer | php7 -- --install-dir=/usr/bin --filename=composer 

RUN  rm -rf /var/cache/apk/*

VOLUME /var/www/html
WORKDIR /var/www/html

EXPOSE 80
EXPOSE 443

CMD /usr/sbin/apachectl  -D   FOREGROUND
