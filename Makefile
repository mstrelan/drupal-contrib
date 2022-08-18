ifneq ("$(shell whoami)", "skpr")
  EXEC=docker-compose exec php-cli
endif

DRUSH=$(EXEC) ./bin/drush
DRUSH_INSTALL=$(DRUSH) -y site:install --account-pass=password
GIT_SWITCH=cd app && git switch

install:
	$(DRUSH_INSTALL)

minimal:
	$(DRUSH_INSTALL) minimal

standard:
	$(DRUSH_INSTALL) standard

umami:
	$(DRUSH_INSTALL) demo_umami

login:
	$(DRUSH) -y user:login

9.3:
	$(GIT_SWITCH) 9.3.x

9.4:
	$(GIT_SWITCH) 9.4.x

9.5:
	$(GIT_SWITCH) 9.5.x

10.0:
	$(GIT_SWITCH) 10.0.x

10.1:
	$(GIT_SWITCH) 10.1.x
