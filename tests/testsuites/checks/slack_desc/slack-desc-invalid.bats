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

@test "Check logs error when slack-desc file is missing" {
  create_empty_package $BATS_TEST_TMPDIR

  rm -f $BATS_TEST_TMPDIR/install/slack-desc

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_NAME=LINTPKG_TEST

  run check

  assert_output "error slack-desc-not-found"
}

@test "Check logs error when slack-desc has wrong package name" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_NAME=LINTPKG_TES

  run check

  assert_output "error slack-desc-description-wrong-packagename LINTPKG_TEST"
}

@test "Check logs error when slack-desc does not have enough lines" {
  create_empty_package $BATS_TEST_TMPDIR

  cp $TEST_STATICS/slack-descs/invalid-not-enough-lines $BATS_TEST_TMPDIR/install/slack-desc

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_NAME=LINTPKG_TEST

  run check

  assert_output "error slack-desc-invalid-number-of-lines 2"
}

@test "Check logs error when slack-desc has too many lines" {
  create_empty_package $BATS_TEST_TMPDIR

  cp $TEST_STATICS/slack-descs/invalid-too-many-lines $BATS_TEST_TMPDIR/install/slack-desc

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_NAME=LINTPKG_TEST

  run check

  assert_output "error slack-desc-invalid-number-of-lines 14"
}

@test "Check logs error when slack-desc has description lines that are too long" {
  create_empty_package $BATS_TEST_TMPDIR

  cp $TEST_STATICS/slack-descs/invalid-description-line-too-long $BATS_TEST_TMPDIR/install/slack-desc

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_NAME=LINTPKG_TEST

  run check

  assert_output "error slack-desc-description-lines-too-long"
}

@test "Check logs warning when slack-desc has a misaligned handy-ruler" {
  create_empty_package $BATS_TEST_TMPDIR

  cp $TEST_STATICS/slack-descs/invalid-handy-ruler-misaligned $BATS_TEST_TMPDIR/install/slack-desc

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_NAME=LINTPKG_TEST

  run check

  assert_output "warning slack-desc-handy-ruler-misaligned"
}

@test "Check logs warning when handy-ruler in slack-desc is too short" {
  create_empty_package $BATS_TEST_TMPDIR

  cp $TEST_STATICS/slack-descs/invalid-handy-ruler-too-short $BATS_TEST_TMPDIR/install/slack-desc

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_NAME=LINTPKG_TEST

  run check

  assert_output "warning slack-desc-handy-ruler-broken"
}

@test "Check logs warning when handy-ruler in slack-desc is too long" {
  create_empty_package $BATS_TEST_TMPDIR

  cp $TEST_STATICS/slack-descs/invalid-handy-ruler-too-long $BATS_TEST_TMPDIR/install/slack-desc

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_NAME=LINTPKG_TEST

  run check

  assert_output "warning slack-desc-handy-ruler-broken"
}

@test "Check logs error when slack-desc contains unrecognized text" {
  create_empty_package $BATS_TEST_TMPDIR

  cp $TEST_STATICS/slack-descs/invalid-unrecognized-text $BATS_TEST_TMPDIR/install/slack-desc

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_NAME=LINTPKG_TEST

  run check

  assert_output "error slack-desc-unrecognised-text"
}
