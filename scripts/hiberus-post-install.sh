#!/bin/bash

echo "==> sudo chown -R wodby:wodby web"
sudo chown -R wodby:wodby web
echo "==> sudo chown -R www-data:www-data web/sites/default/files/"
sudo chown -R www-data:www-data web/sites/default/files/
echo "==> sudo chown -R www-data:www-data files-private"
sudo chown -R www-data:www-data files-private
drush cr
