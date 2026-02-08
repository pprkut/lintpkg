#!/usr/bin/env bats

load ../../helpers/assertions
load ../../helpers/main

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Printing version returns success" {
  run lintpkg -V

  assert_success
}

@test "-V prints version" {
  run lintpkg -V

  assert_output "lintpkg version 0.9.0"
}

@test "--version prints version" {
  run lintpkg --version

  assert_output "lintpkg version 0.9.0"
}
