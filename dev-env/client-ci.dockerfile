FROM node:16

WORKDIR /usr/src/client

COPY ./client/package.json ./
COPY ./client/yarn.lock ./

COPY ./client .