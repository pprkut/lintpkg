#!/usr/bin/env bats

load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/shared_libraries_check.sh"
}

@test "Show explanation for invalid-libtool-archive error" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "invalid-libtool-archive"

  [ "${lines[0]}" == "An invalid libtool archive (.la) file will likely result in linking errors for applications that try to use it." ]

  rm -rf "$BASE"
}
