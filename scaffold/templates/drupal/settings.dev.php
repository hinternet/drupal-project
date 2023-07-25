<?php

/**
 * Disable assets preprocessing
 */
$config['system.performance']['css']['preprocess'] = FALSE;
$config['system.performance']['js']['preprocess'] = FALSE;

/**
 * Override the default filed prefix "field_"
 */
$config['field_ui.settings']['field_prefix'] = '';

/**
 * Avoid ssl verify
 */
$settings['http_client_config'] = ['verify' => FALSE];

/**
 * Override logging verbosity.
 */
$config['system.logging']['error_level'] = 'verbose';

/**
 * Increase database logging records.
 */
$config['dblog.settings']['row_limit'] = 10000;
