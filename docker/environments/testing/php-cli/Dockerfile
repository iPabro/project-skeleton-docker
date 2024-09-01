FROM php:8.2-cli-alpine AS builder

RUN apk add --no-cache fcgi git \
    && docker-php-ext-install \
#      xdebug \
      bcmath
RUN apk add --no-cache libpq-dev \
  libpng-dev \
  libzip-dev
RUN  docker-php-ext-install    gd
RUN  docker-php-ext-install    mysqli
RUN  docker-php-ext-install    pdo
RUN  docker-php-ext-install    pdo_mysql
RUN  docker-php-ext-install    opcache

ENV COMPOSER_ALLOW_SUPERUSER 1

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer --quiet

WORKDIR /app

COPY ./ ./

RUN composer install --no-dev --prefer-dist --no-progress --no-suggest --optimize-autoloader \
    && rm -rf /root/.composer/cache

### CLI ###

FROM php:8.2-cli-alpine

RUN apk add --no-cache fcgi git \
    && docker-php-ext-install \
#      xdebug \
      bcmath
RUN apk add --no-cache libpq-dev \
  libpng-dev \
  libzip-dev
RUN  docker-php-ext-install    gd
RUN  docker-php-ext-install    mysqli
RUN  docker-php-ext-install    pdo
RUN  docker-php-ext-install    pdo_mysql
RUN  docker-php-ext-install    opcache

RUN mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini

COPY ./docker/environments/common/php/conf.d /usr/local/etc/php/conf.d
COPY ./docker/environments/production/php/conf.d /usr/local/etc/php/conf.d

COPY ./docker/environments/common/wait-for-it.sh /usr/local/bin/wait-for-it
RUN chmod 555 /usr/local/bin/wait-for-it

RUN addgroup -g 1000 app && adduser -u 1000 -G app -s /bin/sh -D app

WORKDIR /app

COPY --from=builder /app ./
COPY ./ ./

USER app
