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
        linux* ) cp ./config/docker/docker-compose.linux.yml ./docker-compose.override.yml; break;;
        windows* ) cp ./config/docker/docker-compose.windows.yml ./docker-compose.override.yml; break;;
        macos* ) cp ./config/docker/docker-compose.macos.yml ./docker-compose.override.yml; break;;
        * ) echo "Invalid answer, try again.";;
    esac
done

replace_inline() {
    if [ "$CURRENT_OS" = "Darwin" ]; then
        sed -i '' "${1}" "${2}"
    else
        sed -i "${1}" "${2}"
    fi
}

cp -f ./.env.dist ./.env;

if grep -q "WEB_SERVER=nginx" "./.env"; then
	replace_inline '24,26 s/^#//' ./docker-compose.override.yml
else
	replace_inline '28,30 s/^#//' ./docker-compose.override.yml
fi

printf "Enter your IDE [phpstorm]: ";
read -r REPLY;
IDE=${REPLY:-phpstorm} ;
replace_inline "14,14 s/$/${IDE}/" ./.env
replace_inline "15,15 s/$/${IDE}/" ./.env

### Set proper PHP image for macOS users
if [ "$PROJECT_OS" = "macos" ]; then
	replace_inline '98,98 s/^/#/' ./.env
	replace_inline '104,104 s/^#//' ./.env
fi

echo "==================================";
echo "Onboarding completed!";
echo "##################################";
