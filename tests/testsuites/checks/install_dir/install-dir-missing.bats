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
  mkdir -p $BATS_TEST_TMPDIR/usr/bin
  touch $BATS_TEST_TMPDIR/usr/bin/foo
  chmod +x $BATS_TEST_TMPDIR/usr/bin/foo

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "error no-install-dir"
}

