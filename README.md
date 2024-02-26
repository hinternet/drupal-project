# Drupal Development project

Project scaffold base to start developing Drupal projects, modules and even core using [Drupal Composer project](https://github.com/drupal-composer/drupal-project).

## Prerequisites

The following tools are required in order to bootstrap the project properly:

- [Git](https://git-scm.com/): Needs no introduction, isn't it?
- sed: How else we can parse and modify text streams?
- envsubst: Obviously we care about environment.
- [jq](https://jqlang.github.io/jq/): JSON polisher. Is not a jewel but shines like one.
- [Docker](https://www.docker.com/): It will hunt you down on your dreams like "Free Willy".
- [DDEV](https://ddev.readthedocs.io/en/stable/): The swiss-knife for launching local development environments.
- [GNU/Make](https://www.gnu.org/software/make/): Old, stubborn and reliable building tool.
- [Gum](https://github.com/charmbracelet/gum#installation): The sauce for outter-world shell scripts.

## Scaffolding

To execute the scaffolding process, from your terminal run the following commands:

1. `make setup`: collects configurarion and puts everything in place for the project.
2. `make install`: this will run the Drupal installation script, after it you will have fully functional Drupal site.
3. `make done`: this will terminate the scaffolding process, this command should be run ONLY if everything went well.

In case of errors in any point and if you haven't execute the `make done` command, you cand reset the whole process by running `make clean`.

## Usage

Most common tasks are explained below.

| Command                          | Task                     |
| -------------------------------- | ------------------------ |
| make onboard                     | Setup local environment  |
| make install                     | Install Drupal           |
| make [up:start]                  | Start stack              |
| make [down:stop]                 | Stop stack               |
| make prune                       | Remove all data          |
| ddev ssh                         | Enter PHP container      |
| ddev composer "COMMAND [PARAMS]" | Execute Composer command |
| ddev drush "COMMAND [PARAMS]"    | Execute Drush command    |
| ddev logs [SERVICE]              | Check service logs       |
