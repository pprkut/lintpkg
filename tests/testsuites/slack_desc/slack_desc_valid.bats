#!/usr/bin/env bats

load ../../helpers/locations
load ../../helpers/makepkg
load ../../helpers/mock_loggers

setup() {
  . "$LIVE_CHECKS/slack_desc_check.sh"
}

@test "slack_desc_check logs no error when slack-desc file is valid" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE
  PKG_NAME=LINTPKG_TEST

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "slack_desc_check logs no error when slack-desc file has maximum allowed lines" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  cp $TEST_STATICS/slack-descs/valid-max-lines $BASE/install/slack-desc

  WORKING_DIR=$BASE
  PKG_NAME=LINTPKG_TEST

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "slack_desc_check logs no error when slack-desc file has minimum allowed lines" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  cp $TEST_STATICS/slack-descs/valid-min-lines $BASE/install/slack-desc

  WORKING_DIR=$BASE
  PKG_NAME=LINTPKG_TEST

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "slack_desc_check logs no error when slack-desc file has handy-ruler" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  cp $TEST_STATICS/slack-descs/valid-with-handy-ruler $BASE/install/slack-desc

  WORKING_DIR=$BASE
  PKG_NAME=LINTPKG_TEST

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "slack_desc_check logs no error when slack-desc file has handy-ruler and comments" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  cp $TEST_STATICS/slack-descs/valid-with-comments $BASE/install/slack-desc

  WORKING_DIR=$BASE
  PKG_NAME=LINTPKG_TEST

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

