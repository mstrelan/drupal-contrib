<?php

declare(strict_types=1);

namespace mstrelan\DrupalContrib;

use Composer\Script\Event;

class ComposerScripts {

  /**
   * Configure environment variables.
   */
  public static function configureEnvironment(Event $event): void {
    if (file_exists('.env')) {
      return;
    }
    $io = $event->getIO();
    $io->write("Configuring environment");
    $dist = file_get_contents('.env.dist');
    file_put_contents('.env', str_replace([
      'UID=1000',
      'GID=1000',
    ], [
      sprintf('UID=%d', posix_geteuid()),
      sprintf('GID=%d', posix_getegid()),
    ], $dist));
    $io->write(file_get_contents('.env'));
  }

  /**
   * Clones Drupal core in to the app directory.
   */
  public static function gitCloneDrupalCore(Event $event): void {
    if (file_exists('app/.git')) {
      return;
    }
    $io = $event->getIO();
    $io->write("Cloning Drupal core into 'app'");
    system('git clone https://git.drupalcode.org/project/drupal.git app');
  }

  /**
   * Configures initial PhpStorm settings.
   */
  public static function configurePhpStorm(Event $event): void {
    if (file_exists('.idea')) {
      return;
    }
    $io = $event->getIO();
    if ($io->isInteractive() && !$io->askConfirmation('<info>Do you want to automatically configure PhpStorm?</info> [<comment>Y,n</comment>]? ')) {
      return;
    }
    $io->write("Configuring PhpStorm");
    mkdir('.idea');
    copy('assets/scaffold/files/php.xml', '.idea/php.xml');
    copy('assets/scaffold/files/symfony2.xml', '.idea/symfony2.xml');
    copy('assets/scaffold/files/workspace.xml', '.idea/workspace.xml');
  }

}
