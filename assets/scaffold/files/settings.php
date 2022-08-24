<?php

$databases['default']['default'] = [
  'database' => 'local',
  'username' => 'local',
  'password' => 'local',
  'prefix' => '',
  'host' => '127.0.0.1',
  'port' => '3306',
  'driver' => 'mysql',
];

$settings['hash_salt'] = 'Ydzhf2NAcNCuUNeQHKxyFZ0x0fwWC7FGyvmPC6jG9gmmATSG_2H6923A15VAsty1XloeI0iYDw';
$settings['config_sync_directory'] = 'sites/default/files/config/sync';
$settings['skip_permissions_hardening'] = TRUE;
$settings['trusted_host_patterns'] = [
  '127.0.0.1',
  'localhost',
];

if (file_exists($app_root . '/' . $site_path . '/settings.local.php')) {
  include $app_root . '/' . $site_path . '/settings.local.php';
}
