#!/usr/bin/env bats

TESTSUITE="icon"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/icon_check.sh"
}

@test "[$TESTSUITE] Check logs error when doinst.sh is missing" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/icons/hicolor

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error missing-icon-cache-update hicolor" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when doinst.sh has unconditional update for hicolor icon cache" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/icons/hicolor
  cp $TEST_STATICS/doinst.sh/invalid-hicolor-icon-cache-unconditional $BASE/install/doinst.sh

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error missing-icon-cache-update hicolor" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}
