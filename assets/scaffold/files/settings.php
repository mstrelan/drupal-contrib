<?php

$databases['default']['default'] = array (
  'database' => 'local',
  'username' => 'local',
  'password' => 'local',
  'prefix' => '',
  'host' => '127.0.0.1',
  'port' => '3306',
  'namespace' => 'Drupal\\mysql\\Driver\\Database\\mysql',
  'driver' => 'mysql',
  'autoload' => 'core/modules/mysql/src/Driver/Database/mysql/',
);

$settings['hash_salt'] = 'Ydzhf2NAcNCuUNeQHKxyFZ0x0fwWC7FGyvmPC6jG9gmmATSG_2H6923A15VAsty1XloeI0iYDw';
$settings['config_sync_directory'] = 'sites/default/files/config/sync';
$settings['skip_permissions_hardening'] = TRUE;

if (file_exists($app_root . '/' . $site_path . '/settings.local.php')) {
  include $app_root . '/' . $site_path . '/settings.local.php';
}
