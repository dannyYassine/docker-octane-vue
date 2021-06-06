FROM node:14

COPY ./client /usr/src/client
WORKDIR /usr/src/client

RUN yarn

CMD ["yarn", "serve"]
