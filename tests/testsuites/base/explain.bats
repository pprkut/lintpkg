#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Showing explanation for message identifiers exits with 0" {
  run lintpkg -C "$TEST_CHECKS/logging" -I simple-notice

  assert_success
}

@test "-I shows explanation for message identifier" {
  run lintpkg -C "$TEST_CHECKS/logging" -I simple-notice

  assert_line -n 0 "simple-notice:"
  assert_line -n 1 "A notice for a simple path"
}

@test "--explain shows explanation for message identifier" {
  run lintpkg -C "$TEST_CHECKS/logging" --explain simple-notice

  assert_line -n 0 "simple-notice:"
  assert_line -n 1 "A notice for a simple path"
}

@test "Show explanation for external-compression-utility-missing error" {
  run lintpkg --explain external-compression-utility-missing

  assert_line -n 0 "external-compression-utility-missing:"
  assert_line -n 1 "The necessary compression utility for uncompressing the package is missing."
}
