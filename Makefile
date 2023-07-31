.SHELLFLAGS = -ec
.DEFAULT_GOAL := help

include ./scaffold/make/*.mk

ifneq ($(OS),Windows_NT)
	CURRENT_OS := $(shell uname)
else
	CURRENT_OS := $(OS)
endif

ifeq ($(CURRENT_OS),Darwin)
	SED_INLINE := -i ''
else
	SED_INLINE := -i
endif

.PHONY: setenv
setenv:
	@export CURRENT_OS=$(CURRENT_OS)
	@export SED_INLINE=$(SED_INLINE)

.PHONY: help
help:
	@sed -n 's/^##//p' $(filter-out .env, $(MAKEFILE_LIST))

## install	:	Installs Drupal using the pre-packed configuration
install: ./config ./composer.json ./.env
	@echo "Executing Drupal installation"
	@$(MAKE) up
ifeq ($(CURRENT_OS),Darwin)
	@$(MAKE) mutagen
endif
	@$(MAKE) composer "install --no-interaction"
	@$(MAKE) composer "run-script install-drupal --no-interaction"
	@$(MAKE) drush "si --existing-config -y"
	@echo "Installation finished!"
	@echo "You can log-in by clicking the link below"
	@$(MAKE) drush "user:login"

## test	:	Run scaffolding tests
.PHONY: test
test:
	@./tests/scaffold/run.sh

# https://stackoverflow.com/a/6273809/1826109
%:
	@:
