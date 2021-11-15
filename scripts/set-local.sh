#!/bin/bash

if [ ! -f docker-compose.override.yml ]
then
  ln -fs environments/local/docker-compose.override.yml.dist docker-compose.override.yml
fi

if [ ! -f .env ]
then
  foldername=${PWD##*/}
  cp .env.example .env
  sed -i "s/hdrupal/$foldername/" ./.env
fi

docker-compose build --parallel
docker-compose up -d --remove-orphans
docker-compose exec php composer install
docker-compose exec php composer install
docker-compose exec php drush si --existing-config -y
docker-compose exec php drush uli
