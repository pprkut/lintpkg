#!/usr/bin/env bats

load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/unstripped_binaries_check.sh"
}

@test "Show explanation for unstripped-binary" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "unstripped-binary"

  [ "${lines[0]}" == "ELF binaries and shared libraries are normally stripped, on Slackware." ]

  rm -rf "$BASE"
}
