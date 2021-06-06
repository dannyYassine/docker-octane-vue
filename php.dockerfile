FROM composer:latest as composer
FROM node:14
FROM php:8-fpm

COPY ./api /usr/src/api
WORKDIR /usr/src/api

# install node and npm
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

# install php extensions and libs
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN pecl install xdebug
RUN pecl channel-update https://pecl.php.net/channel.xml \
    && pecl install xdebug swoole

RUN apt-get update
# for M1 macbooks
RUN apt-get install -y mariadb-client
# for non-M1 macbooks
#RUN apt-get install -y mysql-community-client

# enable php extensions
RUN docker-php-ext-enable swoole

# create api bootstrap file
COPY start-container /usr/local/bin/start-container
RUN chmod +x /usr/local/bin/start-container

# setup laravel-octane
RUN yes "1" | php artisan octane:install
RUN npm install --save-dev chokidar

ENTRYPOINT ["start-container"]
