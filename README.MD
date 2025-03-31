#### Если на проекте нужно изменить докеры
скопируй нужное из docker-compose-dev.yml себе
после этого можешь билдить

#### Собрать
сбилдить общий nginx
`make build-nginx-common`

общий php-fpm
`make build-php-fpm-common`

nginx development
`docker --log-level=debug build --file=docker/environments/development/nginx/Dockerfile --tag=ipabro/nginx --progress=plain docker/environments`

php-fpm development
`docker --log-level=debug build --file=docker/environments/development/php-fpm/Dockerfile --tag=ipabro/php-fpm --progress=plain docker/environments`

phpmyadmin
`docker --log-level=debug build --file=docker/environments/development/phpmyadmin/Dockerfile --tag=ipabro/phpmyadmin --progress=plain docker/environments`

ПРОДАКШН ОБРАЗЫ БИЛДЯТСЯ В JENKINS, ЗДЕСЬ НЕ ПОЛУЧИТСЯ


#### Чтоб запушить на сервер
запушиваются сейчас только с тегами latest, хотя если надо какую-то версию, в названии её отражаем

`docker images` - посмотреть, какие сейчас есть образы в системе
`docker login` - залогиниться в докере, чтоб можно было отправлять образы
`docker push ipabro/nginx`
`docker push ipabro/php-fpm`
`docker push ipabro/phpmyadmin`

