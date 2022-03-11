#!/bin/sh

echo "Executing project scaffold script";

### Get project settings

printf "Enter project name (use lowercase letters and underscores): ";
read -r PROJECT_NAME;
export PROJECT_NAME;
printf "Enter the project hostname [localhost]: ";
read -r PROJECT_BASE_URL;
PROJECT_BASE_URL=${PROJECT_BASE_URL:-localhost} ;
export PROJECT_BASE_URL;

while true; do
    printf "Choose your web server ([nginx] or apache): "
    read -r;
    WEB_SERVER=${REPLY:-nginx}
    case $WEB_SERVER in
        nginx|apache* ) export WEB_SERVER; break;;
        * ) echo "Invalid answer, try again.";;
    esac
done

while true; do
    printf "Choose your host OS ([linux], windows, macos): "
    read -r;
    PROJECT_OS=${REPLY:-linux}
    case $PROJECT_OS in
        linux|windows|macos* ) make -f "./toolbox/make/setup.mk" "_$PROJECT_OS"; break;;
        * ) echo "Invalid answer, try again.";;
    esac
done

if [ "$WEB_SERVER" = "nginx" ]; then
	sed -i '' '43,56 s/^#//' ./docker-compose.yml
	sed -i '' '24,26 s/^#//' ./docker-compose.override.yml
else
	sed -i '' '78,89 s/^#//' ./docker-compose.yml
	sed -i '' '28,30 s/^#//' ./docker-compose.override.yml
fi

printf "Enter your IDE [phpstorm]: ";
read -r;
IDE=${REPLY:-phpstorm} ;
export IDE;

### Setup Drupal settings
make -f "./toolbox/make/setup.mk" _setup_drupal;

### Replace vars with provided settings
envsubst <"./toolbox/templates/docker/.env.dist" >"./.env.dist";
cp ./.env.dist ./.env;
envsubst <"./toolbox/templates/testing/lighthouserc.json" >"./lighthouserc.json";
envsubst <"./toolbox/templates/testing/phpunit.xml.dist" >"./phpunit.xml.dist";

echo "Setup testing tools"
make -f "./toolbox/make/setup.mk" _setup_tests;

### Set proper PHP image for macOS users
if [ "$PROJECT_OS" = "macos" ]; then
	sed -i '' '93,93 s/^/#/' ./.env
	sed -i '' '99,99 s/^#//' ./.env
fi
