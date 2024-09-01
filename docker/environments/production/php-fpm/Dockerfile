FROM php-fpm-common
USER root
#ENV COMPOSER_ALLOW_SUPERUSER 1
#
WORKDIR /app
#
#RUN addgroup -g 1000 app && adduser -u 1000 -G app -s /bin/sh -D app
RUN mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini
COPY ./docker/environments/production/php/conf.d /usr/local/etc/php/conf.d

#cron and supervisor
RUN apk --no-cache add supervisor
COPY ./docker/environments/production/php-fpm/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./docker/environments/production/php-fpm/crontab /etc/crontabs/root

COPY ./ ./
#if vendor existst, remove it
RUN rm -rf vendor .env
##COPY ./project_settings/.env ./.env
RUN composer install --no-dev --prefer-dist --no-progress --optimize-autoloader \
    && rm -rf /root/.composer/cache

RUN chmod -R 777 storage bootstrap/cache && chown -R $USER:82 storage && chown -R $USER:82 bootstrap/cache


#RUN chown www-data:www-data ./var -R

HEALTHCHECK --interval=5s --timeout=3s --start-period=1s \
    CMD REDIRECT_STATUS=true SCRIPT_NAME=/ping SCRIPT_FILENAME=/ping REQUEST_METHOD=GET \
    cgi-fcgi -bind -connect 127.0.0.1:9000 || exit 1

#Всем пользователям с группой www-data разрешаем работать с файлами папками кэша
# Добавляем скрипт для установки ACL и делаем его исполняемым
COPY ./docker/environments/production/php-fpm/setfacl-script.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setfacl-script.sh

# Устанавливаем entrypoint
ENTRYPOINT ["/usr/local/bin/setfacl-script.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
