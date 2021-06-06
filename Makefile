build:
	docker-compose up --build
dev:
	docker-compose up
dev-daemon:
	docker-compose up -d
dk-api-ssh:
	docker exec -it docker-swoole-php /bin/bash
dk-migrate:
	docker exec -it docker-swoole-php php artisan migrate