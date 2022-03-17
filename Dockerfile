FROM php:8.1-fpm

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y \
        curl \
        nano \
        unzip \
        libxml2-dev \
        libpng-dev \
        libzip-dev \
        libxslt-dev \
        wget \
        htop
RUN docker-php-ext-install  pdo_mysql bcmath dom intl zip xsl simplexml sysvsem pcntl gd
COPY fpm.conf /usr/local/etc/php-fpm.d/zz-docker.conf
RUN pecl install xdebug && docker-php-ext-enable xdebug \
    && echo 'xdebug.client_port=9001' >> /usr/local/etc/php/php.ini \
    && echo 'xdebug.mode=debug' >> /usr/local/etc/php/php.ini \
    && echo "xdebug.client_host = host.docker.internal" >> /usr/local/etc/php/php.ini