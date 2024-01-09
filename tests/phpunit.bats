DRUPAL_VERSION="${DRUPAL_VERSION:-9.4}"

setup() {
  DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
  cd "$DIR/../" || exit
  BREW_PREFIX="$(brew --prefix)"
  load "${BREW_PREFIX}/lib/bats-assert/load.bash"
}

dce() {
  docker compose exec -T php-cli "$@"
}

phpunit() {
  dce phpunit "$@"
}

@test "Drupal unit test"  {
  run phpunit app/core/tests/Drupal/Tests/Core/DrupalTest.php
  assert_output --partial "OK"
}

@test "Drupal kernel test" {
  run phpunit app/core/tests/Drupal/KernelTests/KernelTestBaseTest.php
  assert_output --partial "OK"
}

@test "Drupal functional test" {
  run phpunit app/core/tests/Drupal/FunctionalTests/BrowserTestBaseTest.php
  assert_output --partial "OK"
}

@test "Drupal functional javascript test" {
  run phpunit app/core/tests/Drupal/FunctionalJavascriptTests/BrowserWithJavascriptTest.php
  assert_output --partial "OK"
}