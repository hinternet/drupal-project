# Drupal Development project

Project scaffold base to start developing Drupal projects, modules and even core. The project scaffold sits on top
[Wodby's Docker4Drupal stack][1] and [Drupal Composer project][2].

## Starting

Before starting the project copy de provided *env* file a *.env* and edit and change to meet your needs. Also if you have cloned this repository **delete** the .git folder on the project root to avoid targeting scaffold repository.

> **IMPORTANT!** MacOS users pay attention to the PHP tag since use a different image than Linux (default).

> **DON'T FORGET** To add the configured project URL in your OS hosts file.

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

Further information is detailed [here](README-wodby.md) and [here](README-composer.md).


[1]: https://wodby.com/docs/stacks/drupal/local/
[2]: https://github.com/drupal-composer/drupal-project
