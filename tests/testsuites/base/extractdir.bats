#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

@test "Setting extraction directory to non-existent path exits with 1" {
  run "${REPO_ROOT}/lintpkg" -E "$TEST_CHECKS/non_existent"

  assert_failure
  assert [ $status -eq 1 ]
}

@test "-E with non-existent directory prints error" {
  run "${REPO_ROOT}/lintpkg" -E "$TEST_CHECKS/non_existent"

  assert_line "Directory does not exist: $TEST_CHECKS/non_existent"
}

@test "--extractdir with non-existent directory prints error" {
  run "${REPO_ROOT}/lintpkg" --extractdir "$TEST_CHECKS/non_existent"

  assert_line "Directory does not exist: $TEST_CHECKS/non_existent"
}

@test "Setting extraction directory to non-writable path exits with 1" {
  mkdir -p /tmp/lintpkg_test_not_writable
  chmod -w /tmp/lintpkg_test_not_writable

  run "${REPO_ROOT}/lintpkg" -E "/tmp/lintpkg_test_not_writable"

  assert_failure
  assert [ $status -eq 1 ]

  rmdir /tmp/lintpkg_test_not_writable
}

@test "-E with non-writable directory prints error" {
  mkdir -p /tmp/lintpkg_test_not_writable
  chmod -w /tmp/lintpkg_test_not_writable

  run "${REPO_ROOT}/lintpkg" -E "/tmp/lintpkg_test_not_writable"

  assert_line "Couldn't create temporary directory"

  rmdir /tmp/lintpkg_test_not_writable
}

@test "--extractdir with non-writable directory prints error" {
  mkdir -p /tmp/lintpkg_test_not_writable
  chmod -w /tmp/lintpkg_test_not_writable

  run "${REPO_ROOT}/lintpkg" --extractdir "/tmp/lintpkg_test_not_writable"

  assert_line "Couldn't create temporary directory"

  rmdir /tmp/lintpkg_test_not_writable
}

@test "Lintpkg extracts package inside extraction directory" {
  create_empty_package "$BATS_TEST_TMPDIR"
  PKG=$(create_slackware_package "$BATS_TEST_TMPDIR" empty 1.0 noarch 1)

  mkdir -p /tmp/lintpkg_test

  run "${REPO_ROOT}/lintpkg" --extractdir "/tmp/lintpkg_test" "$PKG"

  assert_file_exists "$BATS_TEST_TMPDIR/install/slack-desc"
  assert_file_exists "$BATS_TEST_TMPDIR/usr/bin/foo"

  rm -f "$PKG"
  rm -rf /tmp/lintpkg_test
}

@test "Lintpkg removes temporary files from extraction directory" {
  create_empty_package "$BATS_TEST_TMPDIR/package"
  PKG=$(create_slackware_package "$BATS_TEST_TMPDIR/package" empty 1.0 noarch 1)

  mkdir -p "$BATS_TEST_TMPDIR/extract"

  run "${REPO_ROOT}/lintpkg" --extractdir "$BATS_TEST_TMPDIR/extract" "$PKG"

  assert_dir_empty "$BATS_TEST_TMPDIR/extract"

  rm -f "$PKG"
}

@test "Lintpkg removes temporary files from extraction directory without checks" {
  mkdir -p "$BATS_TEST_TMPDIR/extract"

  run "${REPO_ROOT}/lintpkg" --extractdir "$BATS_TEST_TMPDIR/extract" -C "$TEST_CHECKS/empty"

  assert_line "No lint checks found!"
  assert_dir_empty "$BATS_TEST_TMPDIR/extract"
}

@test "Lintpkg removes temporary files from extraction directory when terminated" {
  create_empty_package "$BATS_TEST_TMPDIR/package"
  PKG=$(create_slackware_package "$BATS_TEST_TMPDIR/package" empty 1.0 noarch 1)

  mkdir -p "$BATS_TEST_TMPDIR/extract"

  run "${REPO_ROOT}/lintpkg" --extractdir "$BATS_TEST_TMPDIR/extract" -C "$TEST_CHECKS/interrupt" "$PKG"

  assert [ $status -eq 143 ]
  assert_dir_empty "$BATS_TEST_TMPDIR/extract"

  rm -f "$PKG"
}

@test "Lintpkg extracts package inside extraction directory with spaces in its path" {
  create_empty_package "$BATS_TEST_TMPDIR/package"
  PKG=$(create_slackware_package "$BATS_TEST_TMPDIR/package" empty 1.0 noarch 1)

  mkdir -p "$BATS_TEST_TMPDIR/extract dir"

  run "${REPO_ROOT}/lintpkg" -C "$TEST_CHECKS/pkg_variables" -c pkg_working_dir_check --extractdir "$BATS_TEST_TMPDIR/extract dir" "$PKG"

  assert_line -n 0 --regexp "^$BATS_TEST_TMPDIR/extract dir/lintpkg\\.......\$"
  assert_line -n 1 "1 packages checked; 0 errors and 0 warnings."
  assert_dir_empty "$BATS_TEST_TMPDIR/extract dir"

  rm -f "$PKG"
}
