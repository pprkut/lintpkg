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

@test "Check logs no warning when there is no symlink present" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run check

  refute_output

  rm -rf "$BASE"
}

