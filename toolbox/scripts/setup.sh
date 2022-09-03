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
make -f "./toolbox/make/setup.mk" _docker;

### Select database server
while true; do
    printf "Choose your database server ([mariadb] or postgres): "
    read -r;
    DB_SERVER=${REPLY:-mariadb}
    case $DB_SERVER in
        mariadb|postgres* ) export DB_SERVER; break;;
        * ) echo "Invalid answer, try again.";;
    esac
done

if [ "$DB_SERVER" = "mariadb" ]; then
	sed -i '' '4,17 s/^#//' ./docker-compose.yml
else
	sed -i '' '69,80 s/^#//' ./docker-compose.yml
fi

### Select webserver
while true; do
    printf "Choose your web server ([nginx] or apache): "
    read -r;
    WEB_SERVER=${REPLY:-nginx}
    case $WEB_SERVER in
        nginx|apache* ) export WEB_SERVER; break;;
        * ) echo "Invalid answer, try again.";;
    esac
done

if [ "$WEB_SERVER" = "nginx" ]; then
	sed -i '' '43,58 s/^#//' ./docker-compose.yml
else
	sed -i '' '82,95 s/^#//' ./docker-compose.yml
fi

### Enable ngrok proxy
while true; do
    printf "Do you wish to enable ngrok proxy? "
    read -r yn
    case $yn in
        [Yy]* ) sed -i '' '231,251 s/^#//' ./docker-compose.yml; break;;
        [Nn]* ) echo 'ngrok proxy not enabled'; break;;
        * ) echo "Please answer yes or no.";;
    esac
done

### Setup Drupal settings
make -f "./toolbox/make/setup.mk" _setup_drupal;

### Replace vars with provided settings
envsubst <"./toolbox/templates/docker/.env.dist" >"./.env.dist";
envsubst <"./toolbox/templates/testing/lighthouserc.json" >"./lighthouserc.json";
envsubst <"./toolbox/templates/testing/phpunit.xml.dist" >"./phpunit.xml.dist";

echo "Setup testing tools"
make -f "./toolbox/make/setup.mk" _setup_tests;

### Onboarding
while true; do
    printf "Choose your host OS ([linux], windows, macos): "
    read -r;
    PROJECT_OS=${REPLY:-linux}
    case $PROJECT_OS in
        linux|windows|macos* ) make -f "./toolbox/make/setup.mk" "_$PROJECT_OS"; break;;
        * ) echo "Invalid answer, try again.";;
    esac
done

printf "Enter your IDE [phpstorm]: ";
read -r;
IDE=${REPLY:-phpstorm} ;
export IDE;

envsubst <"./toolbox/templates/docker/.env.dist" >"./.env.dist";
cp ./.env.dist ./.env;

### Set proper PHP image for macOS users
if [ "$PROJECT_OS" = "macos" ]; then
	sed -i '' '98,98 s/^/#/' ./.env
	sed -i '' '104,104 s/^#//' ./.env
fi
