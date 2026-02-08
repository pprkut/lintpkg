#!/usr/bin/env bats

load ../../helpers/assertions
load ../../helpers/main

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Printing usage returns success" {
  run lintpkg -h

  assert_success
}

@test "-h prints usage" {
  run lintpkg -h

  assert_line "Usage: lintpkg [options] <package_filename>"
}

@test "--help prints usage" {
  run lintpkg --help

  assert_line "Usage: lintpkg [options] <package_filename>"
}

@test "Calling lintpkg with no argument prints usage" {
  run lintpkg

  assert_line "Usage: lintpkg [options] <package_filename>"
}
