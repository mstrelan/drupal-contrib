# Drupal contrib starter project

[![tests](https://github.com/mstrelan/drupal-contrib/actions/workflows/tests.yml/badge.svg)](https://github.com/mstrelan/drupal-contrib/actions/workflows/tests.yml)

## Prerequisites

 * Composer
 * Docker / Docker compose
 * PhpStorm (optional)

## Getting started

To get started run the following command:

```
composer create-project mstrelan/drupal-contrib
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
* `10.2|10.3|10.4|11.0|11.x` - provides a clean environment with the specified Drupal version
* `php8.1|php8.2|php8.3` - starts the stack with the specified php version

## PhpStorm configuration

Upon first installation you'll be asked if you want to configure PhpStorm. This will configure
a remote PHP interpreter, PHPUnit and path mappings for debugging.

The remote interpreter assumes that you have Docker integration configured and working already.
See the [Enable Docker support](https://www.jetbrains.com/help/phpstorm/docker.html#enable_docker)
section of the PhpStorm documentation to set this up.

## Running tests

If you elected to automatically configure PhpStorm you should be able to click the green triangle
next to each test in PhpStorm.

Alternatively you can run phpunit on the command line like so:

```
docker-compose exec php-cli bash
phpunit -c app/core/phpunit.xml.dist app/core/tests/Drupal/Tests/Core/DrupalKernel/
```

## Debugging

Xdebug can be enabled for HTTP requests via the Xdebug helper browser extension:

  * Firefox - [Xdebug Helper for Firefox](https://addons.mozilla.org/en-US/firefox/addon/xdebug-helper-for-firefox/)
  * Chrome - [Xdebug helper](https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc)

For CLI scripts including drush and phpunit, use `XDEBUG_SESSION=1`. For example:

You can also toggle Xdebug for debugging tests directly in PhpStorm by clicking the Run Test
button next to a test and choosing Debug.

```
docker-compose exec php-cli bash
XDEBUG_SESSION=1 phpunit app/core/tests/Drupal/Tests/Core/DrupalTest.php --filter=testSetContainer
```

## Debugging WebDriver tests with Selenium and VNC

The `.env.dist` file contains examples for how to configure the `selenium` service to use either
Chrome or Firefox in debug mode. This exposes a VNC port (default 5900) that you can connect to
in order to see tests running in the browser. Using a VNC client such as Remmina or VNC Viewer,
simply connect to port `127.0.0.1:5900` with the password `secret`. If you've changed the `VNC_PORT`
environment variable be sure to connect to that port instead.

## Mailpit

The mailpit service is available and configured to capture email sent from the site. This can be
accessed at http://localhost:8025. For more info see https://github.com/axllent/mailpit.

## Contributing

Once you're up and running you'll have Drupal core checked out in the app directory. From here you
can create a new branch for each issue that you're working on.
