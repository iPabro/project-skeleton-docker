FROM php:8.2-fpm-alpine

RUN apk add --no-cache \
      fcgi \
      git \
      acl \
      libpq-dev \
      libpng-dev \
      libjpeg-turbo-dev \
      libwebp-dev \
      libzip-dev \
      freetype-dev \
      unzip \
      icu-dev \
      gmp \
      gmp-dev \
  && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
  && docker-php-ext-install \
      bcmath\
      gd \
      mysqli \
      pdo \
      pdo_mysql \
      opcache \
      intl \
      zip \
      gmp

COPY ./common/php/conf.d /usr/local/etc/php/conf.d
COPY ./common/php/php-fpm.d /usr/local/etc/php-fpm.d

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer --quiet

RUN addgroup -g 1000 app && adduser -u 1000 -G app -s /bin/sh -D app && addgroup app www-data
USER app
WORKDIR /app

HEALTHCHECK --interval=5s --timeout=3s --start-period=1s \
    CMD REDIRECT_STATUS=true SCRIPT_NAME=/ping SCRIPT_FILENAME=/ping REQUEST_METHOD=GET \
    cgi-fcgi -bind -connect 127.0.0.1:9000 || exit 1
