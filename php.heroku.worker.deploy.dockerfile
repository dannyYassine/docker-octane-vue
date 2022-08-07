FROM composer:latest as composer
FROM node:16
FROM php:8-fpm

COPY ./api /usr/src/api

WORKDIR /usr/src/api

# install node and npm
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

# copy composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# install php extensions and libs
RUN docker-php-ext-install pcntl mysqli pdo pdo_mysql

# install packages
RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y mariadb-client
RUN pecl channel-update https://pecl.php.net/channel.xml \
    && pecl install swoole
    
# install yarn
RUN npm install -g yarn

# install dependencies
RUN composer install --no-dev --no-cache;
RUN yarn;

CMD php artisan queue:work