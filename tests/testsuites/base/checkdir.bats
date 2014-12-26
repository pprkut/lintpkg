#!/usr/bin/env bats

load ../../helpers/locations

@test "setting directory containing checks to non-existant directory exits with 1" {
  run lintpkg -C "$TEST_CHECKS/non_existant"

  [ $status -eq 1 ]
}

@test "-C with non-existant directory prints error message" {
  run lintpkg -C "$TEST_CHECKS/non_existant"

  [ "${lines[0]}" == "Directory does not exist: $TEST_CHECKS/non_existant" ]
  [ "${lines[1]}" == "No lint checks found!" ]
}

@test "--checkdir with non-existant directory prints error message" {
  run lintpkg --checkdir "$TEST_CHECKS/non_existant"

  [ "${lines[0]}" == "Directory does not exist: $TEST_CHECKS/non_existant" ]
  [ "${lines[1]}" == "No lint checks found!" ]
}

@test "setting directory containing checks to empty directory exits with 1" {
  run lintpkg -C "$TEST_CHECKS/empty"

  [ $status -eq 1 ]
}

@test "-C with empty directory prints error message" {
  run lintpkg -C "$TEST_CHECKS/empty"

  [ "${lines[0]}" == "No lint checks found!" ]
}

@test "--checkdir with empty directory prints error message" {
  run lintpkg --checkdir "$TEST_CHECKS/empty"

  [ "${lines[0]}" == "No lint checks found!" ]
}


