#!/usr/bin/env bats

TESTSUITE="icon"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/icon_check.sh"
}

@test "[$TESTSUITE] Check logs no error when doinst.sh has conditional update for hicolor icon cache" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/icons/hicolor
  cp $TEST_STATICS/doinst.sh/valid-hicolor-icon-cache $BASE/install/doinst.sh

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}
