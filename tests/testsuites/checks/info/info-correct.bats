#!/usr/bin/env bats

TESTSUITE="info"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/info_check.sh"
}

@test "[$TESTSUITE] Check logs no error when correct directory and compressed" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/info
  makeinfo $DOCS/lintpkg.texi -o $BASE/usr/info/
  gzip -9 $BASE/usr/info/lintpkg.info

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no warning for png in correct directory" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/info
  touch $BASE/usr/info/lintpkg.png

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

