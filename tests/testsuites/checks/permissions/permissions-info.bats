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
  . "$LIVE_CHECKS/permissions_check.sh"
}

@test "Show explanation for strange-permission warning" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  run info "strange-permission"

  assert_output "A file that you listed to include in your package has strange permissions. Usually, a file should have 0644 permissions and directories should have 0755 permissions."
}
