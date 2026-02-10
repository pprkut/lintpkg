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
  . "$LIVE_CHECKS/shared_libraries_check.sh"
}

@test "Show explanation for invalid-libtool-archive error" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  run info "invalid-libtool-archive"

  assert_output "An invalid libtool archive (.la) file will likely result in linking errors for applications that try to use it."
}
