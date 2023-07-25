#!/bin/sh

echo "WARNING! This will disable the setup scripts and finish the scaffolding phase"
while true; do
    printf "Do you wish to continue? "
    read -r yn
    case $yn in
        [Yy]* ) make -f "$PWD/scaffold/make/setup.mk" _done; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
