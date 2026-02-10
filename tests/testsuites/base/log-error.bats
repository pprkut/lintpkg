#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2022  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Logging error without info" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_error_check "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: E: simple-error /path/to/file"
  assert_line -n 1 "1 packages checked; 1 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging error with info" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_error_check -i "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: E: simple-error /path/to/file"
  assert_line -n 1 "A error for a simple path"
  assert_line -n 2 "1 packages checked; 1 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging error for path with whitespaces without info" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_whitespace_error_check "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: E: whitespace-error /path/t o/a file"
  assert_line -n 1 "1 packages checked; 1 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging error for path with whitespaces with info" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_whitespace_error_check -i "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: E: whitespace-error /path/t o/a file"
  assert_line -n 1 "A error for a path containing whitespaces"
  assert_line -n 2 "1 packages checked; 1 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging error ignored with -x does not print message" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_error_check -x simple-error "$PKG"

  assert_line -n 0 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging error ignored with --exclude does not print message" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_error_check --exclude simple-error "$PKG"

  assert_line -n 0 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging error ignored with -x does not print info message" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_error_check -x simple-error -i "$PKG"

  assert_line -n 0 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging error ignored with --exclude does not print info message" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_error_check --exclude simple-error -i "$PKG"

  assert_line -n 0 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging error removes working directory prefix from path" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_workingdir_error_check "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: E: working-dir-error /usr/bin/foo"
  assert_line -n 1 "1 packages checked; 1 errors and 0 warnings."

  rm -f "$PKG"
}
