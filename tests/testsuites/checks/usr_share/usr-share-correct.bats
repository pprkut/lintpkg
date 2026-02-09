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

@test "Check logs no error when no binary in /usr/share" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/share/test
  echo "foo" > $BATS_TEST_TMPDIR/usr/share/test/bar.txt

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}
