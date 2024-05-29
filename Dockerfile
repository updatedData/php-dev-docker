FROM php:8.3-fpm-bullseye

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y \
        curl \
        nano \
        git \
        unzip \
        libxml2-dev \
        libpng-dev \
        libzip-dev \
        libxslt-dev \
        imagemagick\
        libmagickwand-dev \
        wget \
        htop \
        python3 \
        python3-pip
    
RUN docker-php-ext-install pdo_mysql bcmath soap dom intl zip xsl simplexml sysvsem pcntl gd mysqli sockets exif

COPY fpm.conf /usr/local/etc/php-fpm.d/zz-docker.conf

RUN pecl install redis xdebug mongodb
RUN docker-php-ext-enable xdebug redis mongodb soap
RUN echo 'xdebug.client_port=9003' >> /usr/local/etc/php/php.ini \
    && echo 'xdebug.mode=debug' >> /usr/local/etc/php/php.ini \
    && echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/php.ini \
    && echo "upload_max_filesize=2G" >> /usr/local/etc/php/php.ini \
    && echo "memory_limit=4G" >> /usr/local/etc/php/php.ini \
    && echo "post_max_size=3G" >> /usr/local/etc/php/php.ini

RUN pip install yacron