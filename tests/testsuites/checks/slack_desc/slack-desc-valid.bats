#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/slack_desc_check.sh"
}

@test "Check logs no error when slack-desc file is valid" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_NAME=LINTPKG_TEST

  run check

  refute_output
}

@test "Check logs no error when slack-desc file has maximum allowed lines" {
  create_empty_package $BATS_TEST_TMPDIR

  cp $TEST_STATICS/slack-descs/valid-max-lines $BATS_TEST_TMPDIR/install/slack-desc

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_NAME=LINTPKG_TEST

  run check

  refute_output
}

@test "Check logs no error when slack-desc file has minimum allowed lines" {
  create_empty_package $BATS_TEST_TMPDIR

  cp $TEST_STATICS/slack-descs/valid-min-lines $BATS_TEST_TMPDIR/install/slack-desc

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_NAME=LINTPKG_TEST

  run check

  refute_output
}

@test "Check logs no error when slack-desc file has handy-ruler" {
  create_empty_package $BATS_TEST_TMPDIR

  cp $TEST_STATICS/slack-descs/valid-with-handy-ruler $BATS_TEST_TMPDIR/install/slack-desc

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_NAME=LINTPKG_TEST

  run check

  refute_output
}

@test "Check logs no error when slack-desc file has handy-ruler and comments" {
  create_empty_package $BATS_TEST_TMPDIR

  cp $TEST_STATICS/slack-descs/valid-with-comments $BATS_TEST_TMPDIR/install/slack-desc

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_NAME=LINTPKG_TEST

  run check

  refute_output
}

