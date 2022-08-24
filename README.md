# Drupal contrib starter project

## Prerequisites

 * Composer
 * Docker / Docker compose
 * PhpStorm (optional)

## Getting started

To get started run the following command:

```
composer create-project mstrelan/drupal-contrib:dev-main
```

## Directory structure

* **app/** - this is the web root. The Drupal repo will be checked out here.
* **assets/scaffold/files/** - files that will be copied to their destination with composer.
* **bin/** - vendor binaries go here.
* **src/** - scripts used by composer.
* **vendor/** - composer vendor dir.

## Docker compose

Start the stack by running `docker-compose up` or `make start`.

You can override port numbers and other env vars by copying `.env.dist` to `.env`

The following services are available:

* **nginx** - the webserver
* **php-fpm** - serves the Drupal site
* **php-cli** - a CLI container for interacting with the Drupal site
* **mysql** - an empty database container
* **chrome** - for running webdriver tests

## Makefile targets

Make commands should be executed on the host machine.

* `clean` - runs composer install, installs minimal profile and provides a one-time login link
* `start` - starts the stack
* `stop` - stops the stack
* `stop-php` - stops the php containers
* `minimal` - installs Drupal with the minimal profile
* `standard` - installs Drupal with the standard profile
* `umami` - installs Drupal with the demo_umami profile
* `login` - gets a one-time login link
* `switch` - switches branch, e.g.  `make BRANCH=9.3 switch`
* `9.3|9.4|9.5|10.0|10.1` - provides a clean environment with the specified Drupal version
* `php7.4|php8.0|php8.1` - starts with stack with the specified php version

## PhpStorm configuration

Upon first installation you'll be asked if you want to configure PhpStorm. This will configure
a remote PHP interpreter, PHPUnit and path mappings for debugging.

## Running tests

## Debugging

## Contributing
