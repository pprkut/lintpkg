#!/usr/bin/env bats

load ../../helpers/locations
load ../../helpers/makepkg
load ../../helpers/mock_loggers

setup() {
  . "$LIVE_CHECKS/symlink_check.sh"
}

@test "symlink_check logs no warning when there is no symlink present" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

