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

@test "Check logs error when man page in /usr/share/man" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/share/man/man1
  cp $DOCS/lintpkg.1 $BATS_TEST_TMPDIR/usr/share/man/man1/
  gzip -9 $BATS_TEST_TMPDIR/usr/share/man/man1/lintpkg.1

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "error incorrect-man-dir /usr/share/man"
}

@test "Check logs error when man page in /usr/local/man" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/local/man/man1
  cp $DOCS/lintpkg.1 $BATS_TEST_TMPDIR/usr/local/man/man1/
  gzip -9 $BATS_TEST_TMPDIR/usr/local/man/man1/lintpkg.1

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "error incorrect-man-dir /usr/local/man"
}

@test "Check logs error when man page in /usr/local/share/man" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/local/share/man/man1
  cp $DOCS/lintpkg.1 $BATS_TEST_TMPDIR/usr/local/share/man/man1
  gzip -9 $BATS_TEST_TMPDIR/usr/local/share/man/man1/lintpkg.1

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "error incorrect-man-dir /usr/local/share/man"
}

@test "Check logs warning when uncompressed man page in /usr/man" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/man/man1
  cp $DOCS/lintpkg.1 $BATS_TEST_TMPDIR/usr/man/man1/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "warning uncompressed-man-page $BATS_TEST_TMPDIR/usr/man/man1/lintpkg.1"
}

@test "Check logs warning when uncompressed man page in /usr/share/man" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/share/man/man1
  cp $DOCS/lintpkg.1 $BATS_TEST_TMPDIR/usr/share/man/man1/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "error incorrect-man-dir /usr/share/man"
  expect_output "warning uncompressed-man-page $BATS_TEST_TMPDIR/usr/share/man/man1/lintpkg.1"

  assert_expected_output
}

@test "Check logs warning when uncompressed man page in /usr/local/man" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/local/man/man1
  cp $DOCS/lintpkg.1 $BATS_TEST_TMPDIR/usr/local/man/man1/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "error incorrect-man-dir /usr/local/man"
  expect_output "warning uncompressed-man-page $BATS_TEST_TMPDIR/usr/local/man/man1/lintpkg.1"

  assert_expected_output
}

@test "Check logs warning when uncompressed man page in /usr/local/share/man" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/local/share/man/man1
  cp $DOCS/lintpkg.1 $BATS_TEST_TMPDIR/usr/local/share/man/man1/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "error incorrect-man-dir /usr/local/share/man"
  expect_output "warning uncompressed-man-page $BATS_TEST_TMPDIR/usr/local/share/man/man1/lintpkg.1"

  assert_expected_output
}
