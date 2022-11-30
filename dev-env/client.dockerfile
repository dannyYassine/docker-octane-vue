FROM node:16

RUN pwd

RUN ls

WORKDIR /usr/src/client

RUN pwd

COPY ./client/package*.json ./

RUN ls

RUN yarn

COPY ./client .

CMD yarn dev --host