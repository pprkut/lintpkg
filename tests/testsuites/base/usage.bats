#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2014 Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Printing usage returns success" {
  run ${REPO_ROOT}/lintpkg -h

  assert_success
}

@test "-h prints usage" {
  run ${REPO_ROOT}/lintpkg -h

  assert_line "Usage: lintpkg [options] <package_filename>"
}

@test "--help prints usage" {
  run ${REPO_ROOT}/lintpkg --help

  assert_line "Usage: lintpkg [options] <package_filename>"
}

@test "Calling lintpkg with no argument prints usage" {
  run ${REPO_ROOT}/lintpkg

  assert_line "Usage: lintpkg [options] <package_filename>"
}
