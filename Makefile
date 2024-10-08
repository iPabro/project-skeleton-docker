#e2e ad-hoc
e2e:
	docker compose run --rm cucumber-node-cli yarn e2e

#Запуск проекта с перестройкой или без
build-nginx-common:
	docker --log-level=debug build --file=docker/environments/common/nginx/Dockerfile --tag=nginx-common --progress=plain docker/environments

build-php-fpm-common:
	docker --log-level=debug build --file=docker/environments/common/php-fpm/Dockerfile --tag=php-fpm-common --progress=plain docker/environments

start-dev-pull:
	docker compose up -d --pull always

start-dev:
	docker compose up -d --build

up:
	docker compose up -d

down:
	docker compose down --remove-orphans

#ad-hoc
#init-dev-constuct: proj-permissions build-nginx-common build-php-fpm-common start-dev
init-dev-constuct: build-nginx-common build-php-fpm-common start-dev-pull


#ad-hoc
proj-permissions:
	chmod -R 755 storage bootstrap/cache
	find storage -type f -exec chmod 644 {} \;
	find bootstrap/cache -type f -exec chmod 644 {} \;
	chown -R 1000:82 .

composer-install:
	docker compose exec php-fpm composer install


remove-git-untracked:
	git clean -xdf

copy-env:
	cp .env.example .env
	chown 1000:82 .env

check-database-alive:
	@echo "Ожидание запуска базы данных..."
	@while [ $$(docker compose exec -T oldmysql mysql -u my-local -pmy-local -e "SELECT 1" 2>/dev/null | wc -l) -eq 0 ]; do \
		sleep 1; \
		done
	@echo "База данных запущена и готова к использованию."
fill-database:
	docker compose exec php-fpm php artisan migrate:fresh --seed

prepare-npm:
	docker compose exec node npm install
	docker compose exec node npm run dev

generate-laravel-app-key:
	docker compose exec php-fpm php artisan key:generate

#start-proj: down remove-git-untracked init-dev-constuct composer-install copy-env check-database-alive fill-database generate-laravel-app-key


-include project-specific.mk

# Define default values for callback targets
PRE_START_PROJ ?= pre_start_proj_default
POST_START_PROJ ?= post_start_proj_default

# Default targets that do nothing unless overridden in project-specific.mk
pre_start_proj_default:
	@echo "No project-specific pre-start steps defined."

post_start_proj_default:
	@echo "No project-specific post-start steps defined."

# Main start-proj target
start-proj: down copy-env start-dev-pull composer-install pre_start_proj check-database-alive fill-database generate-laravel-app-key post_start_proj

# Wrapper targets for pre and post steps
pre_start_proj:
	@$(PRE_START_PROJ)

post_start_proj:
	@$(POST_START_PROJ)


init-db-api: db-api-permissions db-api-composer-install db-api-copy-env

db-api-permissions:
	chmod -R 755 storage db-api/bootstrap/cache
	find db-api/storage -type f -exec chmod 644 {} \;
	find db-api/bootstrap/cache -type f -exec chmod 644 {} \;
	chown -R 1000:82 .

db-api-composer-install:
	docker compose exec php-fpm-db-api composer install

db-api-copy-env:
	cp db-api/.env.example db-api/.env
