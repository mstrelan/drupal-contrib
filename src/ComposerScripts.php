<?php

declare(strict_types=1);

namespace mstrelan\DrupalContrib;

use Composer\Script\Event;

class ComposerScripts {

  /**
   * Configure environment variables.
   */
  public static function configureEnvironment(Event $event): void {
    system('make .env');
  }

  /**
   * Clones Drupal core in to the app directory.
   */
  public static function gitCloneDrupalCore(Event $event): void {
    system('make app');
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
    system('make .idea');
  }

}
