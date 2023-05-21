#!/usr/bin/env bats

TESTSUITE="info"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/info_check.sh"
}

@test "[$TESTSUITE] Show explanation for incorrect-info-dir error" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "incorrect-info-dir"

  [ "${lines[0]}" == "Info-pages should be put under /usr/info" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Show explanation for uncompressed-info-page warning" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "uncompressed-info-page"

  [ "${lines[0]}" == "Info-pages should be gzip-compressed" ]

  rm -rf "$BASE"
}
