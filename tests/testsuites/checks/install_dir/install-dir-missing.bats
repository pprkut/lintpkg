#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/install_dir_check.sh"
}

@test "Check logs error when install dir is missing" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  mkdir -p $BASE/usr/bin
  touch $BASE/usr/bin/foo
  chmod +x $BASE/usr/bin/foo

  WORKING_DIR=$BASE

  run check

  assert_output "error no-install-dir"

  rm -rf "$BASE"
}

