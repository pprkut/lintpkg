#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/usr_share_check.sh"
}

@test "Check logs error when binary in /usr/share" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/test
  cp $TEST_STATICS/binaries/hello-x86_64-stripped $BASE/usr/share/test/

  WORKING_DIR=$BASE

  run check

  assert_output "error binary-in-usr-share $BASE/usr/share/test/hello-x86_64-stripped"

  rm -rf "$BASE"
}

@test "Check logs error when shared library in /usr/share" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/test
  cp $TEST_STATICS/binaries/libhello-x86_64-stripped.so $BASE/usr/share/test/

  WORKING_DIR=$BASE

  run check

  assert_output "error binary-in-usr-share $BASE/usr/share/test/libhello-x86_64-stripped.so"

  rm -rf "$BASE"
}

@test "Check logs error when static library in /usr/share" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/test
  cp $TEST_STATICS/binaries/libhello-x86_64-stripped.a $BASE/usr/share/test/

  WORKING_DIR=$BASE

  run check

  assert_output "error binary-in-usr-share $BASE/usr/share/test/libhello-x86_64-stripped.a"

  rm -rf "$BASE"
}
