FROM php:7-fpm-alpine

RUN apk upgrade --update && apk add \
	freetype-dev \
	libjpeg-turbo-dev \
	libpng-dev \
	autoconf

RUN docker-php-ext-install iconv mysqli pdo pdo_mysql \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install gd \
	&& rm -rf /var/cache/apk/*

COPY    www.conf /usr/local/etc/php-fpm.d/www.conf
COPY    php.ini /usr/local/etc/php/php.ini

VOLUME ["/var/www/html", "/usr/local/etc/php-fpm.d", "/var/run/php-fpm"]
