#!/bin/bash

if [ ! -d /home/wodby ]
then
  if [[ ${1} == '-v' ]]; then
    docker-compose exec php bash behat_tests/run_behat_tests.sh -v
  else
    docker-compose exec php bash behat_tests/run_behat_tests.sh
  fi

  exit
fi

if [ ! -f vendor/bin/behat ]; then
  composer require --dev behat/behat dmore/behat-chrome-extension drupal/drupal-extension
else
  bash behat_tests/users.sh -c
  vendor/bin/behat --config behat_tests/behat.yml --init
  if [ ! -f behat_tests/existing_options_es.txt ];then
    echo behat_tests/existing_options_* >> .gitignore
    vendor/bin/behat --config behat_tests/behat.yml -dl --lang es >> behat_tests/existing_options_es.txt
    vendor/bin/behat --config behat_tests/behat.yml -dl --lang en >> behat_tests/existing_options_en.txt
  fi


  if [[ ${1} == '-v' ]]; then
    vendor/bin/behat --config behat_tests/behat.yml
  else
    vendor/bin/behat --config behat_tests/behat.yml -f progress
  fi

  # vendor/bin/behat --config behat_tests/behat.yml --help
  bash behat_tests/users.sh -d
fi


echo "run 'bash behat_tests/run_behat_tests.sh -v' to see verbose"
