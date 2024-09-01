#!/bin/sh
setfacl -R -d -m g:www-data:rwX /app/storage/framework

# Запускаем остальные команды из аргументов
exec "$@"
