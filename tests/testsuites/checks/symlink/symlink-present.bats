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
  . "$LIVE_CHECKS/symlink_check.sh"
}

@test "Check logs warning when a single symlink is present" {
  create_empty_package $BATS_TEST_TMPDIR

  ln -s foo $BATS_TEST_TMPDIR/usr/bin/foo2

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "warning package-contains-symlink $BATS_TEST_TMPDIR/usr/bin/foo2"
}

@test "Check logs warning when multiple symlinks are present" {
  create_empty_package $BATS_TEST_TMPDIR

  ln -s foo $BATS_TEST_TMPDIR/usr/bin/foo2
  ln -s foo $BATS_TEST_TMPDIR/usr/bin/foo3

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "warning package-contains-symlink $BATS_TEST_TMPDIR/usr/bin/foo2"
  expect_output "warning package-contains-symlink $BATS_TEST_TMPDIR/usr/bin/foo3"

  assert_expected_output
}

@test "Check logs warning when a single symlink with spaces in its name is present" {
  create_empty_package $BATS_TEST_TMPDIR

  ln -s foo "$BATS_TEST_TMPDIR/usr/bin/foo 2"

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "warning package-contains-symlink $BATS_TEST_TMPDIR/usr/bin/foo 2"
}

@test "Check logs warning when multiple symlinks with spaces in their name are present" {
  create_empty_package $BATS_TEST_TMPDIR

  ln -s foo "$BATS_TEST_TMPDIR/usr/bin/foo 2"
  ln -s foo "$BATS_TEST_TMPDIR/usr/bin/foo 3"

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "warning package-contains-symlink $BATS_TEST_TMPDIR/usr/bin/foo 2"
  expect_output "warning package-contains-symlink $BATS_TEST_TMPDIR/usr/bin/foo 3"

  assert_expected_output
}
