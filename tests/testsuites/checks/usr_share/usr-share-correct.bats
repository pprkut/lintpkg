#!/usr/bin/env bats

TESTSUITE="usr_share"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/usr_share_check.sh"
}

@test "[$TESTSUITE] Check logs no error when no binary in /usr/share" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/test
  echo "foo" > $BASE/usr/share/test/bar.txt

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}
