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

@test "Check logs warning when incorrect permissions for /etc" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/etc
  chmod 750 $BATS_TEST_TMPDIR/etc

  run check

  assert_output "warning strange-permission $BATS_TEST_TMPDIR/etc 750"
}

@test "Check logs warning when incorrect permissions for /usr" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  chmod 750 $BATS_TEST_TMPDIR/usr

  run check

  assert_output "warning strange-permission $BATS_TEST_TMPDIR/usr 750"
}

@test "Check logs warning when incorrect permissions for directory under /usr" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  chmod 750 $BATS_TEST_TMPDIR/usr/bin

  run check

  assert_output "warning strange-permission $BATS_TEST_TMPDIR/usr/bin 750"
}

