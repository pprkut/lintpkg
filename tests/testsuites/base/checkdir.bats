#!/usr/bin/env bats

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Setting directory containing checks to non-existant directory exits with 1" {
  run lintpkg -C "$TEST_CHECKS/non_existant"

  assert_failure
  assert [ $status -eq 1 ]
}

@test "-C with non-existant directory prints error message" {
  run lintpkg -C "$TEST_CHECKS/non_existant"

  assert_line "Directory does not exist: $TEST_CHECKS/non_existant"
  assert_line "No lint checks found!"
}

@test "--checkdir with non-existant directory prints error message" {
  run lintpkg --checkdir "$TEST_CHECKS/non_existant"

  assert_line "Directory does not exist: $TEST_CHECKS/non_existant"
  assert_line "No lint checks found!"
}

@test "Setting directory containing checks to empty directory exits with 1" {
  run lintpkg -C "$TEST_CHECKS/empty"

  assert_failure
  assert [ $status -eq 1 ]
}

@test "-C with empty directory prints error message" {
  run lintpkg -C "$TEST_CHECKS/empty"

  assert_line "No lint checks found!"
}

@test "--checkdir with empty directory prints error message" {
  run lintpkg --checkdir "$TEST_CHECKS/empty"

  assert_line "No lint checks found!"
}


