build:
	docker-compose build --parallel
build-php:
	docker-compose build php
build-client:
	docker-compose build client
build-mysql:
	docker-compose build mysql
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
	make build
	make dev-daemon
	make post-setup
post-setup:
	dev-env/setup.sh
build-deploy-php:
	docker build -f ./php.deploy.dockerfile -t docker-octane-vue:1.0.0 .
run-deploy-php:
	docker run --name php-deploy -p 8000:8000 docker-octane-vue:1.0.0