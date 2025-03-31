FROM nginx:1.21-alpine

RUN apk add --no-cache curl

COPY ./common/nginx/conf.d /etc/nginx/conf.d
COPY ./common/nginx/nginx.conf /etc/nginx/nginx.conf

WORKDIR /app

HEALTHCHECK --interval=5s --timeout=3s --start-period=1s CMD curl --fail http://127.0.0.1/health/ || exit 1
