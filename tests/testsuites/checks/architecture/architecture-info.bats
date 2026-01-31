#!/usr/bin/env bats

load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/architecture_check.sh"
}

@test "Show explanation for binary-in-wrong-architecture-specific-path" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "binary-in-wrong-architecture-specific-path"

  [ "${lines[0]}" == "There is a binary in the wrong architecture specific path. /usr/lib should not contain 64-bit binaries, /usr/lib64 should not contain 32-bit binaries." ]

  rm -rf "$BASE"
}
