#!/usr/bin/env bats

TESTSUITE="man"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/man_check.sh"
}

@test "[$TESTSUITE] Check logs no error when correct directory and compressed" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/man/man1
  cp $DOCS/lintpkg.1 $BASE/usr/man/man1/
  gzip -9 $BASE/usr/man/man1/lintpkg.1

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}
