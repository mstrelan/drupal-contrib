setup_file() {
  DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
  cd "$DIR/../" || exit
  run make composer
}

setup() {
  load "/home/linuxbrew/.linuxbrew/lib/bats-assert/load.bash"
  load "/home/linuxbrew/.linuxbrew/lib/bats-file/load.bash"
}

dce() {
  docker-compose exec -T php-cli "$@"
}

@test "Composer packages are installed"  {
  run dce composer show --direct -N
  assert_output --partial "drupal/core"
}

@test "Composer files are scaffolded"  {
  assert_file_exist 'app/vendor/autoload.php'
  assert_file_exist 'app/sites/default/settings.php'
  assert_file_exist 'app/.git/info/exclude'
}
