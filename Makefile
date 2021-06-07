build:
	docker-compose build --no-cache --parallel mysql php client
dev:
	docker-compose up
dev-daemon:
	docker-compose up -d
api-ssh:
	docker exec -it docker-swoole-php /bin/bash
migrate:
	docker exec -it docker-swoole-php php artisan migrate