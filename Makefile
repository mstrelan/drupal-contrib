#!/usr/bin/make -f

ifneq ("$(shell whoami)", "skpr")
  EXEC=docker-compose exec -T php-cli
endif

DRUSH=$(EXEC) ./bin/drush
DRUSH_INSTALL=$(DRUSH) -y site:install --account-pass=password
GIT_SWITCH=cd app && git switch
PHP_VERSION=8.0

.PHONY: init clean composer start stop stop-php minimal standard umami login switch 9.3 9.4 9.5 10.0 10.1 php7.4 php8.0 php8.1

init: .env .idea app

clean: app composer minimal login

composer:
	rm -rf composer.lock vendor app/vendor
	$(EXEC) composer install

start: stop-php .env
	PHP_VERSION=$(PHP_VERSION) docker-compose up --build -d

stop:
	docker-compose stop

stop-php:
	docker-compose stop php-cli php-fpm

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

9.5: php8.0
	$(GIT_SWITCH) 9.5.x
	make clean

10.0: php8.1
	$(GIT_SWITCH) 10.0.x
	make clean

10.1: php8.1
	$(GIT_SWITCH) 10.1.x
	make clean

php7.4:
	make start -e PHP_VERSION=7.4

php8.0:
	make start -e PHP_VERSION=8.0

php8.1:
	make start -e PHP_VERSION=8.1

.env:
	cp .env.dist .env
	sed -i 's/UID=1000/UID=$(shell id -u)/g' .env
	sed -i 's/GID=1000/GID=$(shell id -g)/g' .env

.idea:
	cp -R assets/scaffold/.idea/ .idea/

app:
	git clone https://git.drupalcode.org/project/drupal.git app/
