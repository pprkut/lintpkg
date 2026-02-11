#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Setting directory containing checks to non-existent directory exits with 1" {
  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/non_existent"

  assert_failure
  assert [ $status -eq 1 ]
}

@test "-C with non-existent directory prints error message" {
  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/non_existent"

  assert_line "Directory does not exist: $TEST_CHECKS/non_existent"
  assert_line "No lint checks found!"
}

@test "--checkdir with non-existent directory prints error message" {
  run ${REPO_ROOT}/lintpkg --checkdir "$TEST_CHECKS/non_existent"

  assert_line "Directory does not exist: $TEST_CHECKS/non_existent"
  assert_line "No lint checks found!"
}

@test "Setting directory containing checks to empty directory exits with 1" {
  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/empty"

  assert_failure
  assert [ $status -eq 1 ]
}

@test "-C with empty directory prints error message" {
  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/empty"

  assert_line "No lint checks found!"
}

@test "--checkdir with empty directory prints error message" {
  run ${REPO_ROOT}/lintpkg --checkdir "$TEST_CHECKS/empty"

  assert_line "No lint checks found!"
}


