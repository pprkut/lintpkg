#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2022  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/architecture_check.sh"
}

@test "Show explanation for binary-in-wrong-architecture-specific-path" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  run info "binary-in-wrong-architecture-specific-path"

  assert_output "There is a binary in the wrong architecture specific path. /usr/lib should not contain 64-bit binaries, /usr/lib64 should not contain 32-bit binaries."
}
