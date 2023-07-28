#!/bin/sh

echo "##################################";
echo "#  Executing project onboarding  #";
echo "##################################";
echo "Please, answer the following questions to get you up and running";
echo "----------------------------------";

### Onboarding
while true; do
    printf "Choose your host OS ([linux], windows, macos): "
    read -r REPLY;
    PROJECT_OS=${REPLY:-linux}
    case $PROJECT_OS in
        linux* ) cp ./scaffold/templates/docker/docker-compose.linux.yml ./docker-compose.override.yml; break;;
        windows* ) cp ./scaffold/templates/docker/docker-compose.windows.yml ./docker-compose.override.yml; break;;
        macos* ) cp ./scaffold/templates/docker/docker-compose.macos.yml ./docker-compose.override.yml; break;;
        * ) echo "Invalid answer, try again.";;
    esac
done

cp -f ./.env.dist ./.env;

if [ "$WEB_SERVER" = "nginx" ]; then
	sed ${SED_INLINE} '24,26 s/^#//' ./docker-compose.override.yml
else
	sed ${SED_INLINE} '28,30 s/^#//' ./docker-compose.override.yml
fi

printf "Enter your IDE [phpstorm]: ";
read -r REPLY;
IDE=${REPLY:-phpstorm} ;
sed ${SED_INLINE} "14,14 s/$/${IDE}/" ./.env
sed ${SED_INLINE} "15,15 s/$/${IDE}/" ./.env

### Set proper PHP image for macOS users
if [ "$PROJECT_OS" = "macos" ]; then
	sed ${SED_INLINE} '98,98 s/^/#/' ./.env
	sed ${SED_INLINE} '104,104 s/^#//' ./.env
fi

echo "==================================";
echo "Onboarding completed!";
echo "##################################";
