#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Logging prints additional information as given" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/arguments" "$PKG"

  expect_output "empty-1.0-noarch-1: E: glob-error *"
  expect_output "empty-1.0-noarch-1: E: whitespace-error a   b"
  expect_output "empty-1.0-noarch-1: E: option-error -n"
  expect_output "empty-1.0-noarch-1: E: path-error /path/to//file/"
  expect_output "1 packages checked; 4 errors and 0 warnings."

  assert_expected_output

  rm -f "$PKG"
}
