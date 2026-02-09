#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/info_check.sh"
}

@test "Show explanation for incorrect-info-dir error" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  run info "incorrect-info-dir"

  assert_output "Info-pages should be put under /usr/info"
}

@test "Show explanation for uncompressed-info-page warning" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  run info "uncompressed-info-page"

  assert_output "Info-pages should be gzip-compressed"
}
