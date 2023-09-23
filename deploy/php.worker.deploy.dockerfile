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

# install packages
RUN apt-get update
RUN apt-get install -y libpq-dev
RUN apt-get install -y git

# install php extensions and libs
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install pdo pgsql pdo_pgsql
RUN pecl install openswoole-22.0.0

# enable php extensions
RUN docker-php-ext-enable openswoole

# install yarn
RUN npm install -g yarn

# install dependencies
RUN composer install --no-dev --no-cache --ignore-platform-reqs
RUN yarn;

CMD php artisan queue:work & php artisan octane:start --server=swoole --workers=2 --max-requests=250 --host=0.0.0.0 --port=$PORT