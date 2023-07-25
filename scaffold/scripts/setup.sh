#!/bin/sh

echo "#######################################";
echo "#  Executing project scaffold script  #";
echo "#######################################";

### Get project settings

printf "Enter project name (use lowercase letters and underscores): ";
read -r PROJECT_NAME;
export PROJECT_NAME;
printf "Enter the project hostname [localhost]: ";
read -r PROJECT_BASE_URL;
PROJECT_BASE_URL=${PROJECT_BASE_URL:-localhost} ;
export PROJECT_BASE_URL;
echo "---------------------------------------";
make -f "./scaffold/make/setup.mk" _docker;
echo "---------------------------------------";

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
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

### Setup Drupal settings
echo "---------------------------------------";
make -f "./scaffold/make/setup.mk" _setup_drupal;

### Replace vars with provided settings
envsubst <"./scaffold/templates/docker/.env.dist" >"./.env.dist";
envsubst <"./scaffold/templates/testing/lighthouserc.json" >"./lighthouserc.json";
envsubst <"./scaffold/templates/testing/phpunit.xml.dist" >"./phpunit.xml.dist";

make -f "./scaffold/make/setup.mk" _setup_tests;

echo "=======================================";
echo "Project scaffold completed!";
echo "=======================================";
echo "Please, continue by running:";
echo "  * make onboard # To configure your local env";
echo "  * make install # To start the application and run Drupal installer";
echo "  * make done # If everything is ok, finishes the initial setup and executes the first commit";
echo "---------------------------------------";
echo "IMPORTANT!":
echo "In case of errors during setup, onboarding or installation, prior executing done command";
echo "you can reset the whole process by running: make clean";
echo "#######################################";
