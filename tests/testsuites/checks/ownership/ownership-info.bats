#!/usr/bin/env bats

TESTSUITE="ownership"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/ownership_check.sh"
}

@test "[$TESTSUITE] Show explanation for strange-owner-or-group error" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "strange-owner-or-group"

  [ "${lines[0]}" == "The owner and/or group of this object is not root:root." ]

  rm -rf "$BASE"
}
