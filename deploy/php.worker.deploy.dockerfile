FROM composer:latest as composer
FROM php:8-fpm

COPY ./api /usr/src/api

WORKDIR /usr/src/api

# copy composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# install php extensions and libs
RUN docker-php-ext-install pcntl mysqli pdo pdo_mysql

RUN apt-get update
RUN apt-get install -y git

RUN apt-get install -y mariadb-client

CMD php artisan queue:work