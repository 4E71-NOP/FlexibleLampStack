FROM php:7.3.22-apache-buster

# https://github.com/moby/moby/issues/4032#issuecomment-192327844
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update --no-install-recommends --fix-missing

RUN apt-get install --no-install-recommends --fix-missing -y \
    apt-utils \
    build-essential 

RUN apt-get install --no-install-recommends --fix-missing -y \
    curl \
    libcurl4  \
    libcurl4-openssl-dev \
    openssl

# mysql
RUN docker-php-ext-install \
    pdo \
    mysqli \
    pdo_mysql

# postgres
RUN apt-get install --no-install-recommends --fix-missing -y \
    libpq-dev \
    libicu-dev 
RUN docker-php-ext-install \
    pgsql \
    pdo_pgsql
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql

# gd (php) & misc
RUN apt-get install --no-install-recommends --fix-missing -y \
    libonig-dev \
    libfreetype6-dev \
	libicu-dev \
    libjpeg-dev \
	libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
	libssl-dev \
    libwebp-dev \
    libxml2-dev \
    libxpm-dev \
    libzip-dev \
    graphviz \
    zlib1g-dev

RUN docker-php-ext-install \
    zip

RUN docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \ 
    --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install gd

# Enable apache modules
RUN a2enmod rewrite headers

# Cleanup
RUN rm -rf /usr/src/*
