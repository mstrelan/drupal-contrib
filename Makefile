#!/usr/bin/make -f

ifneq ($(shell docker compose version 2>/dev/null),)
  DOCKER_COMPOSE=docker compose
else
  DOCKER_COMPOSE=docker-compose
endif

ifneq ("$(shell whoami)", "skpr")
  EXEC=$(DOCKER_COMPOSE) exec -T php-cli
endif

DRUSH=$(EXEC) ./bin/drush
DRUSH_INSTALL=$(DRUSH) -y site:install --account-pass=password
GIT_SWITCH=cd app && git switch
PHP_VERSION=8.3

clean: composer minimal login

composer:
	rm -rf composer.lock vendor app/vendor
	$(EXEC) composer install --ignore-platform-req=php

start: stop-php
	PHP_VERSION=$(PHP_VERSION) $(DOCKER_COMPOSE) up --build -d

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

11.x: php8.3
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
