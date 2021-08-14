build:
	docker-compose up --build
build-php:
	docker-compose build php
build-daemon:
	docker-compose up -d --build
dev:
	docker-compose up
dev-daemon:
	docker-compose up -d
down:
	docker-compose down
api-ssh:
	docker exec -it docker-swoole-php /bin/bash
client-ssh:
	docker exec -it docker-swoole-php /bin/bash
migrate:
	docker exec -it docker-swoole-php php artisan migrate
setup:
	make build-daemon
	make post-setup
post-setup:
	dev-env/setup.sh