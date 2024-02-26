.SHELLFLAGS = -ec
.DEFAULT_GOAL := help

ifneq ($(OS),Windows_NT)
	CURRENT_OS := $(shell uname)
else
	CURRENT_OS := $(OS)
endif

export CURRENT_OS

.PHONY: help
help:
	@sed -n 's/^##//p' $(filter-out .env, $(MAKEFILE_LIST))

## requirements : Check if all requirements are met
.PHONY: requirements
requirements: gum
	@./project requirements

## setup        : Execute project setup
.PHONY: setup
setup: gum
	@./project setup

## clean        : Delete project setup files
.PHONY: clean
clean: gum
	@./project clean

## done         : Set the scaffold as done, preventing furhter modifications
done: gum
	@./project finish

## onboard      : Setup local environment for the first time
.PHONY: onboard
onboard: gum
	@./project onboard

## install      : Installs Drupal using the pre-packed configuration
install: gum ./config ./composer.json ./.env ./ddev/config.yaml
	@./project install

## up           : Start up containers.
.PHONY: up
up: gum
	@./project start

## start        : Start containers (alias for 'up').
.PHONY: start
start: up

## down         : Stop containers.
.PHONY: down
down: gum ./config ./composer.json ./.env ./ddev/config.yaml
	@./project stop

## stop         : Stop containers (alias for 'down').
.PHONY: stop
stop: down

## prune        : Remove containers and their volumes.
.PHONY: prune
prune: gum ./config ./composer.json ./.env ./ddev/config.yaml
	@./project prune

## test         : Run tests
.PHONY: test
test:
	@./tests/run.sh

# https://stackoverflow.com/a/6273809/1826109
%:
	@:
