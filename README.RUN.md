### Для работы через docker сначала запусти
`curl -s "https://gist.githubusercontent.com/iPabro/d6e9db68bb8bd08b251ccd63287b0481/raw/d.sh?$(date +%s)" | bash`
команда скачает файл из gist, запустит его локально и выполнится команда: скачает файлы docker-compose.yml и Make, добавит в .gitignore файлы, которые не нужны в гите.

#### Для запуска:
- в системе должны быть установлены docker и docker-compose (https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
- в системе должен быть make `apt install make`


#### Команды
- Запустить или пересобрать (например, если переключились на другую ветку). ВСЕ НЕЗАКОММИЧЕННЫЕ ИЗМЕНЕНИЯ ПОТЕРЯЮТСЯ:
  - `make start-proj` - почему-то иногда с первого раза node не запускается, помогает снова пересобрать `make start-proj`

После запуска проект будет находиться по адресу:
- http://localhost

Для доступа в бд
- идём по адресу http://localhost:8085/
- пользователь и пароль одинаковые - my-local, server указывать не надо

Команды выполнять внутри php-fpm, примеры
- `docker compose exec php-fpm php artisan command`
- `docker compose exec php-fpm composer dump-autoload`
- `docker compose exec node npm run dev`

###Тесты
Чтоб запустить тесты на локалке
- `docker compose run --rm cucumber-node-cli yarn e2e-ci`

Чтоб убрать тесты, зайди в cucumber/features и там содержимое файлов с расширением .feature закомментируй с помощью #

#### Запуск без докеров
- `make start-proj-bare`
- затем, если надо в браузере запускать - `php artisan serve`