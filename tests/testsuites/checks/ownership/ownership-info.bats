#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/ownership_check.sh"
}

@test "Show explanation for strange-owner-or-group error" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "strange-owner-or-group"

  assert_output "The owner and/or group of this object is not root:root."

  rm -rf "$BASE"
}
