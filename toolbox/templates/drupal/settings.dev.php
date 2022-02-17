<?php

/**
 * Disable assets preprocessing
 */
$config['system.performance']['css']['preprocess'] = getenv('CSS_PREPROCESS');
$config['system.performance']['js']['preprocess'] = getenv('JS_PREPROCESS');

/**
 * Override the default filed prefix "field_"
 */
$config['field_ui.settings']['field_prefix'] = '';

/**
 * Avoid ssl verify
 */
$settings['http_client_config'] = ['verify' => FALSE];
