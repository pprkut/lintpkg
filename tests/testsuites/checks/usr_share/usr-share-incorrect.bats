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
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/share/test
  cp $TEST_STATICS/binaries/hello-x86_64-stripped $BATS_TEST_TMPDIR/usr/share/test/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "error binary-in-usr-share $BATS_TEST_TMPDIR/usr/share/test/hello-x86_64-stripped"
}

@test "Check logs error when shared library in /usr/share" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/share/test
  cp $TEST_STATICS/binaries/libhello-x86_64-stripped.so $BATS_TEST_TMPDIR/usr/share/test/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "error binary-in-usr-share $BATS_TEST_TMPDIR/usr/share/test/libhello-x86_64-stripped.so"
}

@test "Check logs error when static library in /usr/share" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/share/test
  cp $TEST_STATICS/binaries/libhello-x86_64-stripped.a $BATS_TEST_TMPDIR/usr/share/test/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "error binary-in-usr-share $BATS_TEST_TMPDIR/usr/share/test/libhello-x86_64-stripped.a"
}
