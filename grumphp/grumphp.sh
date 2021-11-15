# rm -fr vendor

composer require --dev \
  "metadrop/grumphp-drupal-check":"^0.3.0 || ^0.2.0"\
  "phpmd/phpmd"

# composer remove --dev \
  # "squizlabs/php_codesniffer":"^3.6"
  # "phpro/grumphp" \
  # "phpstan/phpstan" \
  # "mglaman/phpstan-drupal" \
  # "phpstan/extension-installer":"^1.1" \
  # "drush/drush":">=9.7" \
  # "bex/behat-step-time-logger":"^2.0" \
  # "dealerdirect/phpcodesniffer-composer-installer":"^0.7.0" \
  # "drupal/core-dev":"^9.1 || ^8.9" \
  # "phpspec/prophecy-phpunit":"^2 || ^1" \
  # "php-parallel-lint/php-parallel-lint":"^1.3" \
  # "edgedesign/phpqa":"^1.23" \
  # "metadrop/scripthor":"^1.0" \
  # "metadrop/behat-contexts":"^1.0" \

grumphp git:deinit
# grumphp git:init
grumphp git:pre-commit

