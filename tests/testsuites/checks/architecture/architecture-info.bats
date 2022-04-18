#!/usr/bin/env bats

TESTSUITE="architecture"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/architecture_check.sh"
}

@test "[$TESTSUITE] Show explanation for binary-in-wrong-architecture-specific-path" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "binary-in-wrong-architecture-specific-path"

  [ "${lines[0]}" == "There is a binary in the wrong architecture specific path. /usr/lib should not contain 64-bit binaries, /usr/lib64 should not contain 32-bit binaries." ]

  rm -rf "$BASE"
}
