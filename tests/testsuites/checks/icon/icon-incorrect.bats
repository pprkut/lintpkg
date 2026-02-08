#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/icon_check.sh"
}

@test "Check logs error when doinst.sh is missing" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/icons/hicolor

  WORKING_DIR=$BASE

  run check

  assert_output "error missing-icon-cache-update hicolor"

  rm -rf "$BASE"
}

@test "Check logs error when doinst.sh has unconditional update for hicolor icon cache" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/icons/hicolor
  cp $TEST_STATICS/doinst.sh/invalid-hicolor-icon-cache-unconditional $BASE/install/doinst.sh

  WORKING_DIR=$BASE

  run check

  assert_output "error missing-icon-cache-update hicolor"

  rm -rf "$BASE"
}
