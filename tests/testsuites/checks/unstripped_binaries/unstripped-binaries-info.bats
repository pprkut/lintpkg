#!/usr/bin/env bats

TESTSUITE="unstripped_binaries"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/unstripped_binaries_check.sh"
}

@test "[$TESTSUITE] Show explanation for unstripped-binary" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "unstripped-binary"

  [ "${lines[0]}" == "ELF binaries and shared libraries are normally stripped, on Slackware." ]

  rm -rf "$BASE"
}
