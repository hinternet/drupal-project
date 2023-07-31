## setup	:	Initial project setup
.PHONY: setup
setup: ./scaffold/templates/docker/.env.dist ./scaffold/scripts/setup.sh ./scaffold/scripts/reqs.sh
	@./scaffold/scripts/reqs.sh
	@./scaffold/scripts/setup.sh

## clean	:	Delete project setup files
.PHONY: clean
clean: ./scaffold/scripts/clean.sh _setenv
	@./scaffold/scripts/clean.sh

.PHONY: _clean
_clean:
	@echo "********************************"
	rm -f ./.env* 2>&1
	rm -f ./.eslint* 2>&1
	rm -f ./lighthouserc* 2>&1
	rm -f ./composer* 2>&1
	rm -f ./docker-compose* 2>&1
	rm -f ./grumphp.yml 2>&1
	rm -f ./load.environment.php 2>&1
	rm -f ./package* 2>&1
	rm -f ./phpstan* 2>&1
	rm -f ./phpunit* 2>&1
	rm -f ./rector* 2>&1
	rm -f ./traefik.toml 2>&1
	rm -f ./web/sites/default/settings.* 2>&1
	rm -rf ./.lighthouseci* 2>&1
	rm -rf ./.ssl 2>&1
	rm -rf ./config 2>&1
	rm -rf ./docs 2>&1
	rm -rf ./web/sites/default/files 2>&1
	rm -rf ./files-private 2>&1
	rm -rf ./scripts 2>&1
	rm -rf ./tests/behat 2>&1
	rm -rf ./tests/cypress 2>&1
	rm -rf ./tests/phpunit 2>&1
	rm -rf ./vendor 2>&1
# Restore editorconfig since gets modified during Drupal installation.
	git checkout -- .editorconfig 2>&1
	@echo "********************************"

## done	:	Set the scaffold as done, preventing furhter modifications
done: ./scaffold/scripts/done.sh _setenv
	@./scaffold/scripts/done.sh

_done:
	@echo "Intializing git repository"
ifneq ($(wildcard .git),)
	@echo "There's a git repository already, backed up as .git.orig. If is the scaffold project repository, please deleted it."
	@mv .git .git.orig
endif
	@git init;
	@echo "Comment scaffold ignored files"
	@sed $(SED_INLINE) '3,24 s/^/#/' ./.gitignore
	@echo "Disabling setup routines"
	@mv ./scaffold/make/setup.mk ./scaffold/make/setup.mk.orig
	@git add .
	@git commit -m "Initial commit"

_docker:
	@echo "Copying Docker files"
	cp ./scaffold/templates/docker/docker-compose.yml ./docker-compose.yml
	cp ./scaffold/templates/docker/traefik.toml ./traefik.toml
	cp -r ./scaffold/templates/docker/.ssl ./

_setup_drupal:
	@echo "Setup Drupal files";
	cp ./scaffold/templates/drupal/composer.json ./;
	cp ./scaffold/templates/drupal/load.environment.php ./;
	mkdir -p web/sites/default/files;
	mkdir -p files-private;
	cp ./scaffold/templates/drupal/settings.php ./web/sites/default/;
	cp ./scaffold/templates/drupal/settings.dev.php ./web/sites/default/settings.local.php;
	cp -r ./scaffold/templates/drupal/config ./
	cp -r ./scaffold/templates/drupal/drush ./

_setup_tests: _setup_phpunit _setup_lighthouse _setup_qa
	cp ./scaffold/templates/docker/docker-compose.tests.yml ./

_setup_phpunit:
	cp ./phpunit.xml.dist ./phpunit.xml
	mkdir -p ./tests/phpunit

_setup_lighthouse:
	mkdir -p ./.lighthouseci

_setup_qa:
	cp ./scaffold/templates/testing/grumphp.yml ./
	cp ./scaffold/templates/testing/phpstan.neon ./
	cp ./scaffold/templates/testing/rector.yml ./
	cp ./scaffold/templates/testing/.eslintignore ./
	cp ./scaffold/templates/testing/.eslintrc.json ./
