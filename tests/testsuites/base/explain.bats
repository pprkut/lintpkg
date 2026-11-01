#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main

@test "Showing explanation for message identifiers exits with 0" {
  run "${REPO_ROOT}/lintpkg" -C "$TEST_CHECKS/logging" -I simple-notice

  assert_success
}

@test "-I shows explanation for message identifier" {
  run "${REPO_ROOT}/lintpkg" -C "$TEST_CHECKS/logging" -I simple-notice

  assert_line -n 0 "simple-notice:"
  assert_line -n 1 "A notice for a simple path"
}

@test "--explain shows explanation for message identifier" {
  run "${REPO_ROOT}/lintpkg" -C "$TEST_CHECKS/logging" --explain simple-notice

  assert_line -n 0 "simple-notice:"
  assert_line -n 1 "A notice for a simple path"
}

@test "Show explanation for external-compression-utility-missing error" {
  run "${REPO_ROOT}/lintpkg" --explain external-compression-utility-missing

  assert_line -n 0 "external-compression-utility-missing:"
  assert_line -n 1 "The necessary compression utility for uncompressing the package is missing."
}

@test "Show explanation for messages of lintpkg without any checks" {
  run "${REPO_ROOT}/lintpkg" -C "$TEST_CHECKS/empty" -I external-compression-utility-missing,unused-override

  assert_line -n 0 "external-compression-utility-missing:"
  assert_line -n 1 "The necessary compression utility for uncompressing the package is missing."
  assert_line -n 2 "unused-override:"
  assert_line -n 3 --partial "The package has an override that didn't match any message."
}

@test "-I with checks without explanations shows only the message identifier" {
  run "${REPO_ROOT}/lintpkg" -C "$TEST_CHECKS/pkg_variables" -I unknown-identifier

  assert_output "unknown-identifier:"
}
