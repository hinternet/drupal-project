#!/bin/bash

echo "Set Drupal root owner to wodby"
find . -user wodby -exec chown wodby:wodby {} \;
echo "Set public files owner to the webserver"
find web/sites/* -type d -exec chmod 0755 {} \;
find web/sites/*/files -type f -exec chmod 0644 {} \;
echo "Set private files owner to the webserver"
find files-private -user wodby -exec chown wodby:wodby {} \;
find files-private -type d -exec chmod 0755 {} \;
find files-private -type f -exec chmod 0644 {} \;
