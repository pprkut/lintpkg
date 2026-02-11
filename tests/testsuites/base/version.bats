#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Printing version returns success" {
  run ${REPO_ROOT}/lintpkg -V

  assert_success
}

@test "-V prints version" {
  run ${REPO_ROOT}/lintpkg -V

  assert_output "lintpkg version 0.9.0"
}

@test "--version prints version" {
  run ${REPO_ROOT}/lintpkg --version

  assert_output "lintpkg version 0.9.0"
}
