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
  . "$LIVE_CHECKS/info_check.sh"
}

@test "Check logs error when info page in /usr/share/info" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/share/info
  makeinfo $DOCS/lintpkg.texi -o $BATS_TEST_TMPDIR/usr/share/info/
  gzip -9 $BATS_TEST_TMPDIR/usr/share/info/lintpkg.info

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "error incorrect-info-dir /usr/share/info"
}

@test "Check logs error when info page in /usr/local/info" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/local/info
  makeinfo $DOCS/lintpkg.texi -o $BATS_TEST_TMPDIR/usr/local/info/
  gzip -9 $BATS_TEST_TMPDIR/usr/local/info/lintpkg.info

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "error incorrect-info-dir /usr/local/info"
}

@test "Check logs error when info page in /usr/local/share/info" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/local/share/info
  makeinfo $DOCS/lintpkg.texi -o $BATS_TEST_TMPDIR/usr/local/share/info/
  gzip -9 $BATS_TEST_TMPDIR/usr/local/share/info/lintpkg.info

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "error incorrect-info-dir /usr/local/share/info"
}

@test "Check logs warning when uncompressed info page in /usr/info" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/info
  makeinfo $DOCS/lintpkg.texi -o $BATS_TEST_TMPDIR/usr/info/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "warning uncompressed-info-page $BATS_TEST_TMPDIR/usr/info/lintpkg.info"
}

@test "Check logs warning when uncompressed info page in /usr/share/info" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/share/info
  makeinfo $DOCS/lintpkg.texi -o $BATS_TEST_TMPDIR/usr/share/info/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "error incorrect-info-dir /usr/share/info"
  expect_output "warning uncompressed-info-page $BATS_TEST_TMPDIR/usr/share/info/lintpkg.info"

  assert_expected_output
}

@test "Check logs warning when uncompressed info page in /usr/local/info" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/local/info
  makeinfo $DOCS/lintpkg.texi -o $BATS_TEST_TMPDIR/usr/local/info/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "error incorrect-info-dir /usr/local/info"
  expect_output "warning uncompressed-info-page $BATS_TEST_TMPDIR/usr/local/info/lintpkg.info"

  assert_expected_output
}

@test "Check logs warning when uncompressed info page in /usr/local/share/info" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/local/share/info
  makeinfo $DOCS/lintpkg.texi -o $BATS_TEST_TMPDIR/usr/local/share/info/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "error incorrect-info-dir /usr/local/share/info"
  expect_output "warning uncompressed-info-page $BATS_TEST_TMPDIR/usr/local/share/info/lintpkg.info"

  assert_expected_output
}
