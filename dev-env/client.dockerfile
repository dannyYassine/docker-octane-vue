FROM node:16

WORKDIR /usr/src/client

COPY package*.json ./

RUN yarn

COPY . .

CMD yarn dev --host