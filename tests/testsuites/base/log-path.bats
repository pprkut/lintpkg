#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Logging error for path normalizes path" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/path_logging" -c log_path_error_check "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: E: path-error /usr/bin/foo"
  assert_line -n 1 "empty-1.0-noarch-1: E: path-error /usr/bin/foo"
  assert_line -n 2 "empty-1.0-noarch-1: E: path-error /usr/bin/foo"
  assert_line -n 3 "empty-1.0-noarch-1: E: path-error /usr/bin"
  assert_line -n 4 "empty-1.0-noarch-1: E: path-error /"
  assert_line -n 5 "empty-1.0-noarch-1: E: path-error /usr/bin/foo"
  assert_line -n 6 "empty-1.0-noarch-1: E: path-error /usr/t o/a file"
  assert_line -n 7 "empty-1.0-noarch-1: E: path-error /usr/bin/bar -> foo slacker/root"
  assert_line -n 8 "1 packages checked; 8 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging error for path with info" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/path_logging" -c log_path_error_check -i "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: E: path-error /usr/bin/foo"
  assert_line -n 1 "A error for a path within the package"

  rm -f "$PKG"
}

@test "Logging error for path ignored with -x does not print message" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/path_logging" -c log_path_error_check -x path-error "$PKG"

  assert_output "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging warning for path normalizes path" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/path_logging" -c log_path_warning_check "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: W: path-warning /usr/bin/foo"
  assert_line -n 1 "empty-1.0-noarch-1: W: path-warning /usr/bin/foo"
  assert_line -n 2 "empty-1.0-noarch-1: W: path-warning /usr/bin/foo"
  assert_line -n 3 "empty-1.0-noarch-1: W: path-warning /usr/bin"
  assert_line -n 4 "empty-1.0-noarch-1: W: path-warning /"
  assert_line -n 5 "empty-1.0-noarch-1: W: path-warning /usr/bin/foo"
  assert_line -n 6 "empty-1.0-noarch-1: W: path-warning /usr/t o/a file"
  assert_line -n 7 "empty-1.0-noarch-1: W: path-warning /usr/bin/bar -> foo slacker/root"
  assert_line -n 8 "1 packages checked; 0 errors and 8 warnings."

  rm -f "$PKG"
}

@test "Logging warning for path with info" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/path_logging" -c log_path_warning_check -i "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: W: path-warning /usr/bin/foo"
  assert_line -n 1 "A warning for a path within the package"

  rm -f "$PKG"
}

@test "Logging warning for path ignored with -x does not print message" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/path_logging" -c log_path_warning_check -x path-warning "$PKG"

  assert_output "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging notice for path normalizes path" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/path_logging" -c log_path_notice_check "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: I: path-notice /usr/bin/foo"
  assert_line -n 1 "empty-1.0-noarch-1: I: path-notice /usr/bin/foo"
  assert_line -n 2 "empty-1.0-noarch-1: I: path-notice /usr/bin/foo"
  assert_line -n 3 "empty-1.0-noarch-1: I: path-notice /usr/bin"
  assert_line -n 4 "empty-1.0-noarch-1: I: path-notice /"
  assert_line -n 5 "empty-1.0-noarch-1: I: path-notice /usr/bin/foo"
  assert_line -n 6 "empty-1.0-noarch-1: I: path-notice /usr/t o/a file"
  assert_line -n 7 "empty-1.0-noarch-1: I: path-notice /usr/bin/bar -> foo slacker/root"
  assert_line -n 8 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging notice for path with info" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/path_logging" -c log_path_notice_check -i "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: I: path-notice /usr/bin/foo"
  assert_line -n 1 "A notice for a path within the package"

  rm -f "$PKG"
}

@test "Logging notice for path ignored with -x does not print message" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/path_logging" -c log_path_notice_check -x path-notice "$PKG"

  assert_output "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}
