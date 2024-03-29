#!/usr/bin/env bats

TESTSUITE="symlink"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/symlink_check.sh"
}

@test "[$TESTSUITE] Show explanation for package-contains-symlink error" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "package-contains-symlink"

  [ "${lines[0]}" == "Symbolic link found. These should normally be removed by makepkg." ]

  rm -rf "$BASE"
}
