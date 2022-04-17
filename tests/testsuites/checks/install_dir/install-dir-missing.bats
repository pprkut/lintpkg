#!/usr/bin/env bats

TESTSUITE="install_dir"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/install_dir_check.sh"
}

@test "[$TESTSUITE] Check logs error when install dir is missing" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  mkdir -p $BASE/usr/bin
  touch $BASE/usr/bin/foo
  chmod +x $BASE/usr/bin/foo

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error no-install-dir" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

