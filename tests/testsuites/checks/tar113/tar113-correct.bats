#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/tar113_check.sh"
}

@test "Check logs no error when package was created with tar-1.13" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_LISTING=$(create_tar_listing $BATS_TEST_TMPDIR)

  run check

  refute_output
}
