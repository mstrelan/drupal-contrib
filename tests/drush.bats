DRUPAL_VERSION="${DRUPAL_VERSION:-9.4}"

setup() {
  DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
  cd "$DIR/../" || exit
  load "/home/linuxbrew/.linuxbrew/lib/bats-assert/load.bash"
}

dce() {
  docker-compose exec -T php-cli "$@"
}

drush() {
  dce drush "$@"
}

@test "Drupal version is $DRUPAL_VERSION"  {
  run drush status --fields=drupal-version --format=string
  assert_output --partial "$DRUPAL_VERSION."
}

@test "Drupal bootstrap is successful" {
  run drush status --fields=bootstrap --format=string
  assert_output "Successful"
}

@test "Install minimal profile" {
  run make minimal
  assert_output --partial "[success] Installation complete."
  run drush pm:list --type=profile --field=name
  assert_output minimal
}

@test "Install standard profile" {
  run make standard
  assert_output --partial "[success] Installation complete."
  run drush pm:list --type=profile --field=name
  assert_output standard
}
