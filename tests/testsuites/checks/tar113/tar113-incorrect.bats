#!/usr/bin/env bats

load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/tar113_check.sh"
}

@test "Check logs error when package was not created with tar-1.13" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE
  PKG_LISTING=$(create_tar_listing $BASE new)

  run check

  [ "${lines[0]}" == "error package-not-tar-113" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}
