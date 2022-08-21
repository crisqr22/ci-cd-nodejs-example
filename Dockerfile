FROM node:14.10-alpine as build
RUN set -x \
    && apk update \
    && apk upgrade \
    && apk add --no-cache --update \
        openssl
ARG URL_ENV

WORKDIR /app

COPY package*.json yarn.* ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:14.10-alpine

WORKDIR /app

ARG URL_ENV
ENV URL_ENV=$URL_ENV

COPY --from=build /app/dist ./dist
COPY --from=build /app/package.json ./package.json
COPY --from=build /app/node_modules ./node_modules

CMD npm start