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
  run phpunit app/core/tests/Drupal/Tests/UnitTestCaseTest.php
  assert_success
}

@test "Drupal kernel test" {
  run phpunit app/core/tests/Drupal/KernelTests/KernelTestBaseTest.php --filter=testBootEnvironment
  assert_success
}

@test "Drupal functional test" {
  run phpunit app/core/tests/Drupal/FunctionalTests/BrowserTestBaseTest.php --filter=testGoTo
  assert_success
  assert_output --partial "HTML output was generated"
}

@test "Drupal functional javascript test" {
  run phpunit app/core/tests/Drupal/FunctionalJavascriptTests/BrowserWithJavascriptTest.php --filter=testJavascript
  assert_success
  assert_output --partial "HTML output was generated"
}