FROM composer:latest as composer
FROM node:14
FROM php:8-fpm

WORKDIR /usr/src/api

# install node and npm
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

# copy composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# install php extensions and libs
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN pecl install xdebug
RUN pecl channel-update https://pecl.php.net/channel.xml \
    && pecl install xdebug swoole

RUN apt-get update
RUN apt-get install -y git

# for M1 macbooks support
RUN apt-get install -y mariadb-client

# enable php extensions
RUN docker-php-ext-enable swoole
RUN docker-php-ext-enable xdebug

# install yarn
RUN npm install -g yarn