FROM node:16

RUN pwd

WORKDIR /usr/src/client

RUN pwd

COPY ./client/package*.json ./

RUN yarn

COPY ./client .

CMD yarn dev --host