#!/usr/bin/env bats

TESTSUITE="slack_desc"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/slack_desc_check.sh"
}

@test "[$TESTSUITE] Check logs error when slack-desc file is missing" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  rm -f $BASE/install/slack-desc

  WORKING_DIR=$BASE
  PKG_NAME=LINTPKG_TEST

  run check

  [ "${lines[0]}" == "error slack-desc-not-found" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when slack-desc has wrong package name" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE
  PKG_NAME=LINTPKG_TES

  run check

  [ "${lines[0]}" == "error slack-desc-description-wrong-packagename LINTPKG_TEST" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when slack-desc does not have enough lines" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  cp $TEST_STATICS/slack-descs/invalid-not-enough-lines $BASE/install/slack-desc

  WORKING_DIR=$BASE
  PKG_NAME=LINTPKG_TEST

  run check

  [ "${lines[0]}" == "error slack-desc-invalid-number-of-lines 2" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when slack-desc has too many lines" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  cp $TEST_STATICS/slack-descs/invalid-too-many-lines $BASE/install/slack-desc

  WORKING_DIR=$BASE
  PKG_NAME=LINTPKG_TEST

  run check

  [ "${lines[0]}" == "error slack-desc-invalid-number-of-lines 14" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when slack-desc has description lines that are too long" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  cp $TEST_STATICS/slack-descs/invalid-description-line-too-long $BASE/install/slack-desc

  WORKING_DIR=$BASE
  PKG_NAME=LINTPKG_TEST

  run check

  [ "${lines[0]}" == "error slack-desc-description-lines-too-long" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when slack-desc has a misaligned handy-ruler" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  cp $TEST_STATICS/slack-descs/invalid-handy-ruler-misaligned $BASE/install/slack-desc

  WORKING_DIR=$BASE
  PKG_NAME=LINTPKG_TEST

  run check

  [ "${lines[0]}" == "warning slack-desc-handy-ruler-misaligned" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when handy-ruler in slack-desc is too short" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  cp $TEST_STATICS/slack-descs/invalid-handy-ruler-too-short $BASE/install/slack-desc

  WORKING_DIR=$BASE
  PKG_NAME=LINTPKG_TEST

  run check

  [ "${lines[0]}" == "warning slack-desc-handy-ruler-broken" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when handy-ruler in slack-desc is too long" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  cp $TEST_STATICS/slack-descs/invalid-handy-ruler-too-long $BASE/install/slack-desc

  WORKING_DIR=$BASE
  PKG_NAME=LINTPKG_TEST

  run check

  [ "${lines[0]}" == "warning slack-desc-handy-ruler-broken" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when slack-desc contains unrecognized text" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  cp $TEST_STATICS/slack-descs/invalid-unrecognized-text $BASE/install/slack-desc

  WORKING_DIR=$BASE
  PKG_NAME=LINTPKG_TEST

  run check

  [ "${lines[0]}" == "error slack-desc-unrecognised-text" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}
