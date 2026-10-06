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

  assert_output "path-warning package-contains-symlink $BATS_TEST_TMPDIR/usr/bin/foo2"
}

@test "Check logs warning when multiple symlinks are present" {
  create_empty_package $BATS_TEST_TMPDIR

  ln -s foo $BATS_TEST_TMPDIR/usr/bin/foo2
  ln -s foo $BATS_TEST_TMPDIR/usr/bin/foo3

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "path-warning package-contains-symlink $BATS_TEST_TMPDIR/usr/bin/foo2"
  expect_output "path-warning package-contains-symlink $BATS_TEST_TMPDIR/usr/bin/foo3"

  assert_expected_output
}

@test "Check logs warning when a single symlink with spaces in its name is present" {
  create_empty_package $BATS_TEST_TMPDIR

  ln -s foo "$BATS_TEST_TMPDIR/usr/bin/foo 2"

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "path-warning package-contains-symlink $BATS_TEST_TMPDIR/usr/bin/foo 2"
}

@test "Check logs warning when multiple symlinks with spaces in their name are present" {
  create_empty_package $BATS_TEST_TMPDIR

  ln -s foo "$BATS_TEST_TMPDIR/usr/bin/foo 2"
  ln -s foo "$BATS_TEST_TMPDIR/usr/bin/foo 3"

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "path-warning package-contains-symlink $BATS_TEST_TMPDIR/usr/bin/foo 2"
  expect_output "path-warning package-contains-symlink $BATS_TEST_TMPDIR/usr/bin/foo 3"

  assert_expected_output
}

@test "Symlink warning is counted" {
  create_empty_package $BATS_TEST_TMPDIR
  ln -s foo $BATS_TEST_TMPDIR/usr/bin/bar
  PKG=$(MAKEPKG_OPTIONS="-l n" create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -c symlink_check "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: W: package-contains-symlink /usr/bin/bar"
  assert_line -n 1 "1 packages checked; 0 errors and 1 warnings."
  assert [ $status -eq 64 ]

  rm -f "$PKG"
}
