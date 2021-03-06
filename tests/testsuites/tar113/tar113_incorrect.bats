#!/usr/bin/env bats

load ../../helpers/locations
load ../../helpers/makepkg
load ../../helpers/mock_loggers

setup() {
  . "$LIVE_CHECKS/tar113_check.sh"
}

@test "tar113_check logs no error when package was created with tar-1.13" {
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
