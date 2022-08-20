FROM node:14.10-alpine as build
RUN set -x \
    && apk update \
    && apk upgrade \
    && apk add --no-cache --update \
        openssl

WORKDIR /app

COPY package*.json yarn.* ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:14.10-alpine

WORKDIR /app

COPY --from=build /app/dist ./dist
COPY --from=build /app/package.json ./package.json
COPY --from=build /app/node_modules ./node_modules

CMD npm start