# Для чего
Чтоб был единый докер, а не редактировать его в каждом проекте. Теперь и на локалке и на продакшне одинаковые образы, причём они уже собраны и образы отправлены в docker репозиторий - быстро всё, не нужно собирать.

# Как
Чтоб на проекте использовать этот код, читай README.RUN.MD (кстати, этот файл при установке скопируется в основной проект, чтоб всегда под рукой было, как устанавливать)

# Окружения
Скрипт используется и на локалке и на продакшне и на деве.
На локалке и продакшне
```bash
curl -s "https://gist.githubusercontent.com/iPabro/d6e9db68bb8bd08b251ccd63287b0481/raw/d.sh?$(date +%s)" | bash
```
Для доработки этого скрипта
```bash
curl -s "https://gist.githubusercontent.com/iPabro/d6e9db68bb8bd08b251ccd63287b0481/raw/d.sh?$(date +%s)" | bash -s dev
```
Тогда docker-compose не скопируется, а docker-compose-dev.yml превратится docker-compose.yml - чтоб можно было билдить, а не качать готовые образы

В целом и дальше по установке на рабочие проекты в README.RUN.MD

# Далее инструкция по доработке этого докер-окружения:

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

