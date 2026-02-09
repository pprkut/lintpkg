#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/icon_check.sh"
}

@test "Show explanation for missing-icon-cache-update error" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  run info "missing-icon-cache-update"

  assert_output "Icon theme contents are cached in an mmap()-able cache file. Whenever installing new icons, this cache file should be updated in doinst.sh."
}
