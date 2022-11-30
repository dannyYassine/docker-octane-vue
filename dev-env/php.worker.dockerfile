FROM composer:latest as composer
FROM php:8-fpm

WORKDIR /usr/src/api

# copy composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# install php extensions and libs
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN pecl install xdebug
RUN pecl install openswoole-4.11.1

RUN apt-get update
RUN apt-get install -y git

# for M1 macbooks support
RUN apt-get install -y mariadb-client

# enable php extensions
RUN docker-php-ext-enable openswoole

COPY ./api .

# install dependencies
RUN composer install --no-dev --no-cache;