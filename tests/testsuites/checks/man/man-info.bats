#!/usr/bin/env bats

TESTSUITE="man"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/man_check.sh"
}

@test "[$TESTSUITE] Show explanation for incorrect-man-dir error" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "incorrect-man-dir"

  [ "${lines[0]}" == "Man-pages should be put under /usr/man" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Show explanation for uncompressed-man-page warning" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "uncompressed-man-page"

  [ "${lines[0]}" == "Man-pages should be gzip-compressed" ]

  rm -rf "$BASE"
}
