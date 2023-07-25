#!/bin/sh

echo "WARNING! Scaffolded files and directories will be DESTROYED"
while true; do
    printf "Do you wish to continue? "
    read -r yn
    case $yn in
        [Yy]* ) make -f "$PWD/scaffold/make/setup.mk" _clean; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

