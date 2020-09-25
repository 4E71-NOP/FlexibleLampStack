FROM php:7.4.2-apache-buster

# https://github.com/moby/moby/issues/4032#issuecomment-192327844
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y 

# mysql
RUN docker-php-ext-install \
    pdo \
    mysqli \
    pdo_mysql

# postgres
RUN apt-get install --no-install-recommends -y \
    libpq-dev \
    libicu-dev 
RUN docker-php-ext-install \
    pgsql \
    pdo_pgsql
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql

# gd (php) & misc
RUN apt-get install --no-install-recommends -y \
    libmcrypt-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libxml2-dev \
    libxpm-dev \
    zlib1g-dev \
    libzip-dev \
    libonig-dev \
    graphviz

RUN docker-php-ext-install \
    zip \
    -j$(nproc) gd
    # mbstring \

RUN docker-php-ext-configure gd 

# # Enable apache modules
# RUN a2enmod rewrite headers

# # Cleanup
# RUN rm -rf /usr/src/*

