#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/usr_share_check.sh"
}

@test "Show explanation for binary-in-usr-share" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  run info "binary-in-usr-share"

  assert_output "The /usr/share directory is for architecture-independent data, and should not contain object code such as ELF executables or shared libraries."
}
