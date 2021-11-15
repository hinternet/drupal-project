#!/bin/bash

echo "=======> SUDO APK UPDATE"
sudo apk update &>/dev/null

echo "=======> ACTUALIZAMOS E INSTALAMOS DEPENDENCIAS"
sudo apk add unzip zip

echo "=======> ZSH FOR FREAKS"
curl -s https://gitlab.com/-/snippets/2185597/raw/main/install-zsh-alpine.sh | bash &>/dev/null


# drush cr
# drush sql-drop -y
# sudo rm -fr /tmp/* web/sites/default/files/*
# composer install --dev
# drush si -y
# drush uli


# echo "=======> ADD CACERT 2 CURLRC"
# echo 'cacert = "/home/wodby/.ssh/cacert.pem"' >> ~/.curlrc;


# echo "=======> XDEBUG"
# pecl install xdebug-2.9.8

# # configuramos php
# ENV PHP_INI_DIR /usr/local/etc/php
# COPY environment/local/php.ini.dist /tmp/copiar/
# RUN cp --force "/tmp/copiar/php.ini.dist" "$PHP_INI_DIR/php.ini"
# # RUN cp --force "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# # Borramos el enlace simbolico que creo la imagen padre.
# RUN rm -rf /var/www/html/*

# # configuramos entorno
# COPY environment/local/localvhost.conf /tmp/copiar/
# COPY environment/local/xdebug.ini /tmp/copiar/

# RUN cp -f /tmp/copiar/xdebug.ini "$PHP_INI_DIR/conf.d/xdebug.ini"
# RUN cp -f /tmp/copiar/localvhost.conf /etc/apache2/sites-enabled/000-default.conf
# RUN ln -sf /opt/drupalmitma /var/www/html
# RUN rm -rf /tmp/copiar
# RUN chown www-data:www-data /var/www/html/ -R
# RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# # Instalamos drush
# RUN composer global require drush/drush

# # Cambiamos la carpeta vendor incluida en el PATH del sistema para no perder funcionalidad del contenedor
# RUN rm -fr /opt/drupal/vendor composer* && ln -sf /opt/drupalmitma/vendor /opt/drupal/vendor

# # establecemos el directorio de trabajo
# WORKDIR /var/www/html/drupalmitma

# # Ejecutamos el script bash para autoconfigurar base de datos y ejecutamos el apache
# CMD apachectl -D FOREGROUND
