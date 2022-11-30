FROM node:16

RUN pwd

RUN ls

WORKDIR /usr/src/client

RUN pwd

COPY ./client/package.json ./
COPY ./client/yarn.lock ./

RUN ls

RUN yarn

COPY ./client .

RUN ls

CMD yarn dev --host