#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

@test "Setting directory containing checks to non-existent directory exits with 1" {
  run "${REPO_ROOT}/lintpkg" -C "$TEST_CHECKS/non_existent"

  assert_failure
  assert [ $status -eq 1 ]
}

@test "-C with non-existent directory prints error message" {
  run "${REPO_ROOT}/lintpkg" -C "$TEST_CHECKS/non_existent"

  assert_line "Directory does not exist: $TEST_CHECKS/non_existent"
  assert_line "No lint checks found!"
}

@test "--checkdir with non-existent directory prints error message" {
  run "${REPO_ROOT}/lintpkg" --checkdir "$TEST_CHECKS/non_existent"

  assert_line "Directory does not exist: $TEST_CHECKS/non_existent"
  assert_line "No lint checks found!"
}

@test "Setting directory containing checks to empty directory exits with 1" {
  run "${REPO_ROOT}/lintpkg" -C "$TEST_CHECKS/empty"

  assert_failure
  assert [ $status -eq 1 ]
}

@test "-C with empty directory prints error message" {
  run "${REPO_ROOT}/lintpkg" -C "$TEST_CHECKS/empty"

  assert_line "No lint checks found!"
}

@test "--checkdir with empty directory prints error message" {
  run "${REPO_ROOT}/lintpkg" --checkdir "$TEST_CHECKS/empty"

  assert_line "No lint checks found!"
}

@test "Uses checks next to the lintpkg script by default" {
  mkdir -p "$BATS_TEST_TMPDIR/app/checks"
  cp "${REPO_ROOT}/lintpkg" "$BATS_TEST_TMPDIR/app/"
  cp "$TEST_CHECKS/pkg_variables/pkg_name_check.sh" "$BATS_TEST_TMPDIR/app/checks/"

  create_empty_package "$BATS_TEST_TMPDIR/pkg"
  PKG=$(create_slackware_package "$BATS_TEST_TMPDIR/pkg" empty 1.0 noarch 1)

  run "$BATS_TEST_TMPDIR/app/lintpkg" "$PKG"

  assert_line -n 0 "empty"
  assert_line -n 1 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Uses checks from a directory with spaces in its path" {
  mkdir -p "$BATS_TEST_TMPDIR/check dir"
  cp "$TEST_CHECKS/pkg_variables/pkg_name_check.sh" "$BATS_TEST_TMPDIR/check dir/"

  create_empty_package "$BATS_TEST_TMPDIR/pkg"
  PKG=$(create_slackware_package "$BATS_TEST_TMPDIR/pkg" empty 1.0 noarch 1)

  run "${REPO_ROOT}/lintpkg" -C "$BATS_TEST_TMPDIR/check dir" "$PKG"

  assert_line -n 0 "empty"
  assert_line -n 1 "1 packages checked; 0 errors and 0 warnings."

  run "${REPO_ROOT}/lintpkg" -C "$BATS_TEST_TMPDIR/check dir" -I "unknown-message"

  assert_output "unknown-message:"

  rm -f "$PKG"
}

@test "Uses checks with spaces in their file name" {
  mkdir -p "$BATS_TEST_TMPDIR/checks"
  cp "$TEST_CHECKS/pkg_variables/pkg_name_check.sh" "$BATS_TEST_TMPDIR/checks/pkg name check.sh"
  cp "$TEST_CHECKS/logging/log_error_check.sh" "$BATS_TEST_TMPDIR/checks/log error check.sh"

  create_empty_package "$BATS_TEST_TMPDIR/pkg"
  PKG=$(create_slackware_package "$BATS_TEST_TMPDIR/pkg" empty 1.0 noarch 1)

  run "${REPO_ROOT}/lintpkg" -C "$BATS_TEST_TMPDIR/checks" "$PKG"

  expect_output "empty-1.0-noarch-1: E: simple-error /path/to/file"
  expect_output "empty"
  expect_output "1 packages checked; 1 errors and 0 warnings."

  assert_expected_output

  run "${REPO_ROOT}/lintpkg" -C "$BATS_TEST_TMPDIR/checks" -c "pkg name check" "$PKG"

  assert_output "empty
1 packages checked; 0 errors and 0 warnings."

  run "${REPO_ROOT}/lintpkg" -C "$BATS_TEST_TMPDIR/checks" -I "simple-error"

  assert_output "simple-error:
A error for a simple path"

  rm -f "$PKG"
}
