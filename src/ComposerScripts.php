<?php

declare(strict_types=1);

namespace mstrelan\DrupalContrib;

use Composer\Script\Event;

class ComposerScripts {

  /**
   * Clones Drupal core in to the app directory.
   */
  public static function gitCloneDrupalCore(Event $event): void {
    if (file_exists('app/.git')) {
      return;
    }
    $io = $event->getIO();
    $io->write("Cloning Drupal core into 'app'.");
    system('git clone https://git.drupalcode.org/project/drupal.git app');
  }

}
