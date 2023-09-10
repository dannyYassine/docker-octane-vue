build:
	make pre-setup
	docker-compose build --parallel
build-no-cache:
	make pre-setup
	docker-compose build --parallel --no-cache
build-php:
	docker-compose build php
build-worker:
	docker-compose build worker
build-client:
	docker-compose build client
build-db:
	docker-compose build postgres
build-daemon:
	docker-compose up -d --build
dev:
	docker-compose up
dev-daemon:
	docker-compose up -d
down:
	docker-compose down
api-setup:
	make api-install &&\
	make api-key &&\
	make api-migrate-refresh
api-install:
	docker exec -it api composer install --no-cache --ignore-platform-reqs && yarn
api-key:
	docker exec -it api php artisan key:generate
api-debug:
	docker exec -it api php artisan serve --host 0.0.0.0 --port 8000
api-migrate:
	docker exec -it api php artisan migrate
api-migrate-refresh:
	docker exec -it api php artisan migrate:fresh --seed
api-serve:
	docker exec -it api php artisan octane:start --server=swoole --watch --workers=2 --max-requests=250 --host=0.0.0.0 --port=8000
api-ssh:
	docker exec -it api /bin/bash
api-restart:
	docker-compose restart api --no-deps
client-serve:
	docker exec -it client yarn dev
client-ssh:
	docker exec -it client /bin/bash
playwright-ssh:
	docker exec -it playwright /bin/bash
worker-listen:
	php artisan queue:listen
migrate:
	docker exec -it api php artisan migrate
pre-setup:
	dev-env/pre-setup.sh
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
run-worker:
	docker run --name worker -p 8000:8000 docker-octane-vue:1.0.0
test-php:
	docker exec docker-swoole-php /usr/src/api/vendor/bin/phpunit \
	--configuration /usr/src/api/phpunit.xml \
	--colors=auto