#!/usr/bin/env bats

TESTSUITE="shared_libraries"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/shared_libraries_check.sh"
}

@test "[$TESTSUITE] Show explanation for invalid-libtool-archive error" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "invalid-libtool-archive"

  [ "${lines[0]}" == "An invalid libtool archive (.la) file will likely result in linking errors for applications that try to use it." ]

  rm -rf "$BASE"
}
