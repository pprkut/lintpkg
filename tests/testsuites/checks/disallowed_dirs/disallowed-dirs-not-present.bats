#!/usr/bin/env bats

TESTSUITE="disallowed_dirs"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/disallowed_dirs_check.sh"
}

@test "[$TESTSUITE] Check logs no error when there is no disallowed directory present" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}
