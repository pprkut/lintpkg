#!/usr/bin/env bats

load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/icon_check.sh"
}

@test "Show explanation for missing-icon-cache-update error" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "missing-icon-cache-update"

  [ "${lines[0]}" == "Icon theme contents are cached in an mmap()-able cache file. Whenever installing new icons, this cache file should be updated in doinst.sh." ]

  rm -rf "$BASE"
}
