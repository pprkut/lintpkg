#!/usr/bin/env bats

TESTSUITE="tar113"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/tar113_check.sh"
}

@test "[$TESTSUITE] Show explanation for package-not-tar-113 error" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "package-not-tar-113"

  [ "${lines[0]}" == "The package does not have tar-1.13 format member names. It was not created with makepkg." ]

  rm -rf "$BASE"
}
