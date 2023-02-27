FROM composer:latest as composer
FROM php:8-fpm

WORKDIR /usr/src/api

# copy composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# # install packages
# RUN apt-get update
# RUN apt-get install -y libpq-dev
# RUN apt-get install -y git

# # install php extensions and libs
# RUN docker-php-ext-install pcntl
# RUN docker-php-ext-install pdo pgsql pdo_pgsql

COPY ./api .

# install dependencies
RUN composer install --ignore-platform-reqs