# Drupal Development project

Project scaffold base to start developing Drupal projects, modules and even core. The project scaffold sits on top
[Wodby's Docker4Drupal stack](https://wodby.com/docs/stacks/drupal/local/) and [Drupal Composer project](https://github.com/drupal-composer/drupal-project).

## Scaffolding

To execute the scaffolding process, from your terminal run the following commands:
1. `make setup`: collects configurarion and puts everything in place for the project.
2. `make onboard`: after setup is completed you must run this command to get your local environment ready to start the project.
3. `make install`: this will run the Drupal installation script, after it you will have fully functional Drupal site.
4. `make done`: this will terminate the scaffolding process, this command should be run ONLY if everything went well.

In case of errors in any point and you haven't execute the `make done` command, you cand reset the whole process by running `make clean`.

## Usage

Most common tasks are explained below, also for each task a GNU/Make target is provided.

| Make                             | Docker                                               | Task                         |
| -------------------------------- | ---------------------------------------------------- | ---------------------------- |
| make onboard                     | -                                                    | Setup local environment      |
| make install                     | -                                                    | Install Drupal               |
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

| Container       | Versions           | Image                              | ARM64 support | Enabled by default |
|-----------------|--------------------|------------------------------------|---------------|--------------------|
| [Nginx]         | 1.23, 1.22, 1.21   | [wodby/nginx]                      | ✓             | ✓                  |
| [Apache]        | 2.4                | [wodby/apache]                     | ✓             |                    |
| [Drupal]        | 9, 8, 7            | [wodby/drupal]                     | ✓             | ✓                  |
| [PHP]           | 8.1, 8.0, 7.4      | [wodby/drupal-php]                 | ✓             |                    |
| Crond           |                    | [wodby/drupal-php]                 | ✓             | ✓                  |
| [MariaDB]       | 10.8-10.3          | [wodby/mariadb]                    | ✓             | ✓                  |
| [PostgreSQL]    | 14, 13, 12, 11, 10 | [wodby/postgres]                   | ✓             |                    |
| [Redis]         | 7, 6, 5            | [wodby/redis]                      | ✓             |                    |
| [Memcached]     | 1                  | [wodby/memcached]                  |               |                    |
| [Varnish]       | 6.0, 4.1           | [wodby/varnish]                    | ✓             |                    |
| [Node.js]       | 18,  16, 14        | [wodby/node]                       |               |                    |
| [Drupal node]   | 1.0                | [wodby/drupal-node]                |               |                    |
| [Solr]          | 8, 7, 6, 5         | [wodby/solr]                       |               |                    |
| Zookeeper       | 3.8                | [zookeeper]                        |               |                    |
| [Elasticsearch] | 7, 6               | [wodby/elasticsearch]              |               |                    |
| [Kibana]        | 7, 6               | [wodby/kibana]                     |               |                    |
| [OpenSMTPD]     | 6.0                | [wodby/opensmtpd]                  |               |                    |
| [Mailhog]       | latest             | [mailhog/mailhog]                  |               | ✓                  |
| [AthenaPDF]     | 2.16.0             | [arachnysdocker/athenapdf-service] |               |                    |
| [Rsyslog]       | latest             | [wodby/rsyslog]                    |               |                    |
| [Blackfire]     | latest             | [blackfire/blackfire]              |               |                    |
| [Webgrind]      | 1                  | [wodby/webgrind]                   |               |                    |
| [Xhprof viewer] | latest             | [wodby/xhprof]                     |               |                    |
| Adminer         | 4.6                | [wodby/adminer]                    |               |                    |
| phpMyAdmin      | latest             | [phpmyadmin/phpmyadmin]            |               |                    |
| Selenium chrome | 3.141              | [selenium/standalone-chrome]       |               |                    |
| Traefik         | latest             | [_/traefik]                        | ✓             | ✓                  |
| Lighthouse      | latest             | [pixboost/lighthouse-ci-cli]       |               | ✓ (tests-only)     |
| Cypress         | latest             | [cypress/included]                 |               | ✓ (tests-only)     |
| Ngrok           | latest             | [wernight/ngrok]                   |               |                    |

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


[Apache]: https://wodby.com/docs/stacks/drupal/containers#apache
[AthenaPDF]: https://wodby.com/docs/stacks/drupal/containers#athenapdf
[Blackfire]: https://wodby.com/docs/stacks/drupal/containers#blackfire
[Drupal node]: https://wodby.com/docs/stacks/drupal/containers#drupal-nodejs
[Drupal]: https://wodby.com/docs/stacks/drupal/containers#php
[Elasticsearch]: https://wodby.com/docs/stacks/elasticsearch
[Kibana]: https://wodby.com/docs/stacks/elasticsearch
[Mailhog]: https://wodby.com/docs/stacks/drupal/containers#mailhog
[MariaDB]: https://wodby.com/docs/stacks/drupal/containers#mariadb
[Memcached]: https://wodby.com/docs/stacks/drupal/containers#memcached
[Nginx]: https://wodby.com/docs/stacks/drupal/containers#nginx
[Node.js]: https://wodby.com/docs/stacks/drupal/containers#nodejs
[OpenSMTPD]: https://wodby.com/docs/stacks/drupal/containers#opensmtpd
[PHP]: https://wodby.com/docs/stacks/drupal/containers#php
[PostgreSQL]: https://wodby.com/docs/stacks/drupal/containers#postgresql
[Redis]: https://wodby.com/docs/stacks/drupal/containers#redis
[Rsyslog]: https://wodby.com/docs/stacks/drupal/containers#rsyslog
[Solr]: https://wodby.com/docs/stacks/drupal/containers#solr
[Varnish]: https://wodby.com/docs/stacks/drupal/containers#varnish
[Webgrind]: https://wodby.com/docs/stacks/drupal/containers#webgrind
[XHProf viewer]: https://wodby.com/docs/stacks/php/containers#xhprof-viewer

[_/traefik]: https://hub.docker.com/_/traefik
[arachnysdocker/athenapdf-service]: https://hub.docker.com/r/arachnysdocker/athenapdf-service
[blackfire/blackfire]: https://hub.docker.com/r/blackfire/blackfire
[mailhog/mailhog]: https://hub.docker.com/r/mailhog/mailhog
[phpmyadmin/phpmyadmin]: https://hub.docker.com/r/phpmyadmin/phpmyadmin
[selenium/standalone-chrome]: https://hub.docker.com/r/selenium/standalone-chrome
[wodby/adminer]: https://hub.docker.com/r/wodby/adminer
[wodby/apache]: https://github.com/wodby/apache
[wodby/drupal-node]: https://github.com/wodby/drupal-node
[wodby/drupal-php]: https://github.com/wodby/drupal-php
[wodby/drupal]: https://github.com/wodby/drupal
[wodby/elasticsearch]: https://github.com/wodby/elasticsearch
[wodby/kibana]: https://github.com/wodby/kibana
[wodby/mariadb]: https://github.com/wodby/mariadb
[wodby/memcached]: https://github.com/wodby/memcached
[wodby/nginx]: https://github.com/wodby/nginx
[wodby/node]: https://github.com/wodby/node
[wodby/opensmtpd]: https://github.com/wodby/opensmtpd
[wodby/postgres]: https://github.com/wodby/postgres
[wodby/redis]: https://github.com/wodby/redis
[wodby/rsyslog]: https://hub.docker.com/r/wodby/rsyslog
[wodby/solr]: https://github.com/wodby/solr
[wodby/varnish]: https://github.com/wodby/varnish
[wodby/webgrind]: https://hub.docker.com/r/wodby/webgrind
[wodby/xhprof]: https://hub.docker.com/r/wodby/xhprof
[zookeeper]: https://hub.docker.com/_/zookeeper
[pixboost/lighthouse-ci-cli]: https://hub.docker.com/r/pixboost/lighthouse-ci-cli
[cypress/included]: https://hub.docker.com/r/cypress/included
[wernight/ngrok]: https://hub.docker.com/r/wernight/ngrok
