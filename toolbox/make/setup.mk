## setup	:	Initial project setup
.PHONY: setup
setup: ./toolbox/templates/.env.dist ./toolbox/scripts/setup.sh ./toolbox/scripts/reqs.sh
	@./toolbox/scripts/reqs.sh
	@./toolbox/scripts/setup.sh

## clean	:	Delete project setup files
.PHONY: clean
clean: ./toolbox/scripts/clean.sh
	@./toolbox/scripts/clean.sh

.PHONY: _clean
_clean:
	@echo "********************************"
	rm -f ./.env* 2>&1
	rm -f ./.eslint* 2>&1
	rm -f ./lighthouserc* 2>&1
	rm -f ./composer* 2>&1
	rm -f ./docker-compose* 2>&1
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
done: ./toolbox/scripts/done.sh
	@./toolbox/scripts/done.sh

_done:
	@echo "Intializing git repository"
ifneq ($(wildcard .git),)
	@echo "There's a git repository already, backed up as .git.orig. If is the scaffold project repository, please deleted it."
	@mv .git .git.orig
endif
	@git init;
	@echo "Comment scaffold ignored files"
	@sed -i '' '3,23 s/^/#/' ./.gitignore
	@echo "Disabling setup routines"
	@mv ./toolbox/make/setup.mk ./toolbox/make/setup.mk.orig
	@git add .
	@git commit -m "Initial commit"

_docker:
	@echo "Copying Docker files"
	cp ./toolbox/templates/docker/docker-compose.yml ./docker-compose.yml
	cp ./toolbox/templates/docker/traefik.toml ./traefik.toml
	cp -r ./toolbox/templates/docker/.ssl ./

_linux: _docker
	cp ./toolbox/templates/docker/docker-compose.linux.yml ./docker-compose.override.yml

_windows: _docker
	cp ./toolbox/templates/docker/docker-compose.windows.yml ./docker-compose.override.yml

_macos: _docker
	cp ./toolbox/templates/docker/docker-compose.macos.yml ./docker-compose.override.yml

_setup_drupal:
	@echo "Setup Drupal files";
	cp ./toolbox/templates/drupal/composer.json ./;
	cp ./toolbox/templates/drupal/load.environment.php ./;
	mkdir -p web/sites/default/files;
	cp ./toolbox/templates/drupal/settings.php ./web/sites/default/;
	cp ./toolbox/templates/drupal/settings.local.php ./web/sites/default/;
	cp -r ./toolbox/templates/drupal/config ./

_setup_tests: _setup_phpunit _setup_lighthouse _setup_qa

_setup_phpunit:
	cp ./phpunit.xml.dist ./phpunit.xml
	mkdir -p ./tests/phpunit

_setup_lighthouse:
	mkdir -p ./.lighthouseci

_setup_qa:
	cp ./toolbox/templates/testing/grumphp.yml ./
	cp ./toolbox/templates/testing/phpstan.neon ./
	cp ./toolbox/templates/testing/rector.yml ./
	cp ./toolbox/templates/testing/.eslintignore ./
	cp ./toolbox/templates/testing/.eslintrc.json ./
