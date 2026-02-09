#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/permissions_check.sh"
}

@test "Check logs no warning when correct permissions for /etc" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/etc
  chmod 755 $BATS_TEST_TMPDIR/etc

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}

@test "Check logs no warning when correct permissions for /usr" {
  create_empty_package $BATS_TEST_TMPDIR

  chmod 755 $BATS_TEST_TMPDIR/usr

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}

@test "Check logs no warning when correct permissions for directory under /usr" {
  create_empty_package $BATS_TEST_TMPDIR

  chmod 755 $BATS_TEST_TMPDIR/usr/bin

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}

