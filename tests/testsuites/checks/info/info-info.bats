#!/usr/bin/env bats

load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/info_check.sh"
}

@test "Show explanation for incorrect-info-dir error" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "incorrect-info-dir"

  [ "${lines[0]}" == "Info-pages should be put under /usr/info" ]

  rm -rf "$BASE"
}

@test "Show explanation for uncompressed-info-page warning" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "uncompressed-info-page"

  [ "${lines[0]}" == "Info-pages should be gzip-compressed" ]

  rm -rf "$BASE"
}
