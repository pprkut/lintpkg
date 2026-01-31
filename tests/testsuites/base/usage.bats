#!/usr/bin/env bats

load ../../helpers/main

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Printing usage returns success" {
  run lintpkg -h

  [ $status -eq 0 ]
}

@test "-h prints usage" {
  run lintpkg -h

  [ "${lines[0]}" == "Usage: lintpkg [options] <package_filename>" ]
}

@test "--help prints usage" {
  run lintpkg --help

  [ "${lines[0]}" == "Usage: lintpkg [options] <package_filename>" ]
}

@test "Calling lintpkg with no argument prints usage" {
  run lintpkg

  [ "${lines[0]}" == "Usage: lintpkg [options] <package_filename>" ]
}
