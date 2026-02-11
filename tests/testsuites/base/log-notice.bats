#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2022  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Logging notice without info" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/logging" -c log_notice_check "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: I: simple-notice /path/to/file"
  assert_line -n 1 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging notice with info" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/logging" -c log_notice_check -i "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: I: simple-notice /path/to/file"
  assert_line -n 1 "A notice for a simple path"
  assert_line -n 2 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging notice for path with whitespaces without info" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/logging" -c log_whitespace_notice_check "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: I: whitespace-notice /path/t o/a file"
  assert_line -n 1 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging notice for path with whitespaces with info" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/logging" -c log_whitespace_notice_check -i "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: I: whitespace-notice /path/t o/a file"
  assert_line -n 1 "A notice for a path containing whitespaces"
  assert_line -n 2 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging notice ignored with -x does not print message" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/logging" -c log_notice_check -x simple-notice "$PKG"

  assert_line -n 0 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging notice ignored with --exclude does not print message" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/logging" -c log_notice_check --exclude simple-notice "$PKG"

  assert_line -n 0 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging notice ignored with -x does not print info message" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/logging" -c log_notice_check -x simple-notice -i "$PKG"

  assert_line -n 0 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging notice ignored with --exclude does not print info message" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/logging" -c log_notice_check --exclude simple-notice -i "$PKG"

  assert_line -n 0 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging notice removes working directory prefix from path" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/logging" -c log_workingdir_notice_check "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: I: working-dir-notice /usr/bin/foo"
  assert_line -n 1 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}
