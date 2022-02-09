.SHELLFLAGS = -e
.DEFAULT_GOAL := help

include ./toolbox/make/*.mk

ifneq ($(OS),Windows_NT)
	CURRENT_OS := $(shell uname)
else
	CURRENT_OS := $(OS)
endif

.PHONY: help
help:
	@sed -n 's/^##//p' $(filter-out .env, $(MAKEFILE_LIST))

## install	:	Installs Drupal using the pre-packed configuration
install: ./config ./composer.json ./.env
	@$(MAKE) up
ifeq ($(CURRENT_OS),Darwin)
	@$(MAKE) mutagen
endif
	@$(MAKE) composer "install --no-interaction"
	@$(MAKE) composer "run-script install-drupal --no-interaction"
	@$(MAKE) drush "si --existing-config -y"

## test	:	Run scaffolding tests
.PHONY: test
test:
	@./tests/scaffold/run.sh

# https://stackoverflow.com/a/6273809/1826109
%:
	@:
