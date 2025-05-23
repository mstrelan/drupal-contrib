#!/usr/bin/make -f

ifneq ($(shell docker compose version 2>/dev/null),)
  DOCKER_COMPOSE=docker compose
else
  DOCKER_COMPOSE=docker-compose
endif

ifneq ("$(shell whoami)", "skpr")
  EXEC=$(DOCKER_COMPOSE) exec -T php-cli
  EXEC_APP=$(DOCKER_COMPOSE) exec -w /data/app -T php-cli
endif

DRUSH=$(EXEC) ./bin/drush
DRUSH_INSTALL=$(DRUSH) -y site:install --account-pass=password
GIT_SWITCH=cd app && git switch
PHP_VERSION=8.4

clean: composer minimal login

composer:
	rm -rf composer.lock vendor app/vendor
	mkdir -p app/composer/Plugin/RecipeUnpack
	$(EXEC) composer install --ignore-platform-req=php

start: stop-php
	PHP_VERSION=$(PHP_VERSION) $(DOCKER_COMPOSE) up --build -d --wait

stop:
	$(DOCKER_COMPOSE) stop

stop-php:
	$(DOCKER_COMPOSE) stop php-cli php-fpm

minimal:
	$(DRUSH_INSTALL) minimal

standard:
	$(DRUSH_INSTALL) standard

umami:
	$(DRUSH_INSTALL) demo_umami

login:
	$(DRUSH) -y user:login

switch:
	$(GIT_SWITCH) $(BRANCH)

phpstan:
	$(EXEC_APP) /data/bin/phpstan --configuration=./core/phpstan.neon.dist --memory-limit=1G

phpstan-baseline:
	$(EXEC_APP) /data/bin/phpstan --configuration=./core/phpstan.neon.dist --generate-baseline=./core/.phpstan-baseline.php --memory-limit=1G

9.3: php8.0
	$(GIT_SWITCH) 9.3.x
	make clean

9.4: php8.0
	$(GIT_SWITCH) 9.4.x
	make clean

9.5: php8.1
	$(GIT_SWITCH) 9.5.x
	make clean

10.0: php8.1
	$(GIT_SWITCH) 10.0.x
	make clean

10.1: php8.2
	$(GIT_SWITCH) 10.1.x
	make clean

10.2: php8.2
	$(GIT_SWITCH) 10.2.x
	make clean

10.3: php8.3
	$(GIT_SWITCH) 10.3.x
	make clean

10.4: php8.3
	$(GIT_SWITCH) 10.4.x
	make clean

10.5: php8.3
	$(GIT_SWITCH) 10.5.x
	make clean

11.0: php8.3
	$(GIT_SWITCH) 11.0.x
	make clean

11.1: php8.3
	$(GIT_SWITCH) 11.1.x
	make clean

11.2: php8.4
	$(GIT_SWITCH) 11.2.x
	make clean

11.x: php8.4
	$(GIT_SWITCH) 11.x
	make clean

php7.4:
	make start -e PHP_VERSION=7.4

php8.0:
	make start -e PHP_VERSION=8.0

php8.1:
	make start -e PHP_VERSION=8.1

php8.2:
	make start -e PHP_VERSION=8.2

php8.3:
	make start -e PHP_VERSION=8.3

php8.4:
	make start -e PHP_VERSION=8.4
