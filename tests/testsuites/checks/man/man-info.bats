#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/man_check.sh"
}

@test "Show explanation for incorrect-man-dir error" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "incorrect-man-dir"

  assert_output "Man-pages should be put under /usr/man"

  rm -rf "$BASE"
}

@test "Show explanation for uncompressed-man-page warning" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "uncompressed-man-page"

  assert_output "Man-pages should be gzip-compressed"

  rm -rf "$BASE"
}
