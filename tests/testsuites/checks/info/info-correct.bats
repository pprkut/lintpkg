#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/info_check.sh"
}

@test "Check logs no error when correct directory and compressed" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/info
  makeinfo $DOCS/lintpkg.texi -o $BATS_TEST_TMPDIR/usr/info/
  gzip -9 $BATS_TEST_TMPDIR/usr/info/lintpkg.info

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}

@test "Check logs no warning for png in correct directory" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/info
  touch $BATS_TEST_TMPDIR/usr/info/lintpkg.png

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}

