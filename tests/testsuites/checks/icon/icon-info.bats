#!/usr/bin/env bats

TESTSUITE="icon"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/icon_check.sh"
}

@test "[$TESTSUITE] Show explanation for missing-icon-cache-update error" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "missing-icon-cache-update"

  [ "${lines[0]}" == "Icon theme contents are cached in an mmap()-able cache file. Whenever installing new icons, this cache file should be updated in doinst.sh." ]

  rm -rf "$BASE"
}
