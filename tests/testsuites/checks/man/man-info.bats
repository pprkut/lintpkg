#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2023  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

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
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  run info "incorrect-man-dir"

  assert_output "Man-pages should be put under /usr/man"
}

@test "Show explanation for uncompressed-man-page warning" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  run info "uncompressed-man-page"

  assert_output "Man-pages should be gzip-compressed"
}
