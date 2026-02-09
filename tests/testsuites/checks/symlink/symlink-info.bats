#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/symlink_check.sh"
}

@test "Show explanation for package-contains-symlink error" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  run info "package-contains-symlink"

  assert_output "Symbolic link found. These should normally be removed by makepkg."
}
