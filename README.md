# Drupal Development project

Project scaffold base to start developing Drupal projects, modules and even core. The project scaffold sits on top
[Wodby's Docker4Drupal stack](https://wodby.com/docs/stacks/drupal/local/) and [Drupal Composer project](https://github.com/drupal-composer/drupal-project).

## Starting

@TODO Add setup instructions

## Usage

Most common tasks are explained below, also for each task a GNU/Make target is provided.

| Make                             | Docker                                               | Task                         |
| -------------------------------- | ---------------------------------------------------- | ---------------------------- |
| make [up:start]                  | docker-compose pull                                  | Start stack                  |
|                                  | docker-compose up -d --remove-orphans                |                              |
| make [down:stop]                 | docker-compose stop                                  | Stop stack                   |
| make shell                       | docker-compose exec php sh                           | Enter PHP container          |
| make composer "COMMAND [PARAMS]" | docker-compose exec php "composer COMMAND [PARAMS] " | Execute Composer command     |
| make drush "COMMAND [PARAMS]"    | docker-compose exec php "drush COMMAND [PARAMS] "    | Execute Drush command        |
| make logs [SERVICE]              | docker-compose logs [SERVICE]                        | Check service logs           |
| make prune [SERVICE]             | docker-compose down -v [SERVICE]                     | Remove service (deleted all) |

## Stack

The Drupal stack consist of the following containers:

| Container       | Versions                | Image                              | ARM64 support | Enabled by default |
|-----------------|-------------------------|------------------------------------|---------------|--------------------|
| [Nginx]         | 1.21, 1.20, 1.19        | [wodby/nginx]                      | ✓             | ✓                  |
| [Apache]        | 2.4                     | [wodby/apache]                     | ✓             |                    |
| [Drupal]        | 9, 8, 7                 | [wodby/drupal]                     | ✓             | ✓                  |
| [PHP]           | 8.1, 8.0, 7.4           | [wodby/drupal-php]                 | ✓             |                    |
| Crond           |                         | [wodby/drupal-php]                 | ✓             | ✓                  |
| [MariaDB]       | 10.6, 10.5, 10.4, 10.3  | [wodby/mariadb]                    | ✓             | ✓                  |
| [PostgreSQL]    | 14, 13, 12, 11, 10, 9.6 | [wodby/postgres]                   | ✓             |                    |
| [Redis]         | 6, 5                    | [wodby/redis]                      | ✓             |                    |
| [Memcached]     | 1                       | [wodby/memcached]                  |               |                    |
| [Varnish]       | 6.0, 4.1                | [wodby/varnish]                    |               |                    |
| [Node.js]       | 16, 14, 12              | [wodby/node]                       |               |                    |
| [Drupal node]   | 1.0                     | [wodby/drupal-node]                |               |                    |
| [Solr]          | 8, 7, 6, 5              | [wodby/solr]                       |               |                    |
| [Elasticsearch] | 7, 6                    | [wodby/elasticsearch]              |               |                    |
| [Kibana]        | 7, 6                    | [wodby/kibana]                     |               |                    |
| [OpenSMTPD]     | 6.0                     | [wodby/opensmtpd]                  |               |                    |
| [Mailhog]       | latest                  | [mailhog/mailhog]                  |               | ✓                  |
| [AthenaPDF]     | 2.16.0                  | [arachnysdocker/athenapdf-service] |               |                    |
| [Rsyslog]       | latest                  | [wodby/rsyslog]                    |               |                    |
| [Blackfire]     | latest                  | [blackfire/blackfire]              |               |                    |
| [Webgrind]      | 1                       | [wodby/webgrind]                   |               |                    |
| [Xhprof viewer] | latest                  | [wodby/xhprof]                     |               |                    |
| Adminer         | 4.6                     | [wodby/adminer]                    |               |                    |
| phpMyAdmin      | latest                  | [phpmyadmin/phpmyadmin]            |               |                    |
| Selenium chrome | 3.141                   | [selenium/standalone-chrome]       |               |                    |
| Traefik         | latest                  | [_/traefik]                        | ✓             | ✓                  |

Supported Drupal versions: 9

### Images' tags

Images tags format is `[VERSION]-[STABILITY_TAG]` where:

`[VERSION]` is the _version of an application_ (without patch version) running in a container, e.g. `wodby/nginx:1.15-x.x.x` where Nginx version is `1.15` and `x.x.x` is a stability tag. For some images we include both major and minor version like PHP `7.2`, for others we include only major like Redis `5`.

`[STABILITY_TAG]` is the _version of an image_ that corresponds to a git tag of the image repository, e.g. `wodby/mariadb:10.2-3.3.8` has MariaDB `10.2` and stability tag [`3.3.8`](https://github.com/wodby/mariadb/releases/tag/3.3.8). New stability tags include patch updates for applications and image's fixes/improvements (new env vars, orchestration actions fixes, etc). Stability tag changes described in the corresponding a git tag description. Stability tags follow [semantic versioning](https://semver.org/).

We highly encourage to use images only with stability tags.

### Maintenance

We regularly update images used in this stack and release them together, see [releases page](https://github.com/wodby/docker4drupal/releases) for full changelog and update instructions. Most of routine updates for images and this project performed by [the bot](https://github.com/wodbot) via scripts located at [wodby/images](https://github.com/wodby/images).

### Support

* Read the docs on [**how to use**](https://wodby.com/docs/stacks/drupal/local#usage)
* Ask questions on [Slack](http://slack.wodby.com/)
* Follow [@wodbycloud](https://twitter.com/wodbycloud) for future announcements
