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

@test "Calling lintpkg with no argument returns success" {
  run ${REPO_ROOT}/lintpkg

  assert_success
}

@test "-I without argument prints usage and exits with 1" {
  run ${REPO_ROOT}/lintpkg -I

  assert_line "Usage: lintpkg [options] <package_filename>"
  assert [ $status -eq 1 ]
}

@test "--explain without argument prints usage and exits with 1" {
  run ${REPO_ROOT}/lintpkg --explain

  assert_line "Usage: lintpkg [options] <package_filename>"
  assert [ $status -eq 1 ]
}

@test "-c without argument prints usage and exits with 1" {
  run ${REPO_ROOT}/lintpkg -c

  assert_line "Usage: lintpkg [options] <package_filename>"
  assert [ $status -eq 1 ]
}

@test "--check without argument prints usage and exits with 1" {
  run ${REPO_ROOT}/lintpkg --check

  assert_line "Usage: lintpkg [options] <package_filename>"
  assert [ $status -eq 1 ]
}

@test "-C without argument prints usage and exits with 1" {
  run ${REPO_ROOT}/lintpkg -C

  assert_line "Usage: lintpkg [options] <package_filename>"
  assert [ $status -eq 1 ]
}

@test "--checkdir without argument prints usage and exits with 1" {
  run ${REPO_ROOT}/lintpkg --checkdir

  assert_line "Usage: lintpkg [options] <package_filename>"
  assert [ $status -eq 1 ]
}

@test "--overridedir without argument prints usage and exits with 1" {
  run ${REPO_ROOT}/lintpkg --overridedir

  assert_line "Usage: lintpkg [options] <package_filename>"
  assert [ $status -eq 1 ]
}

@test "-E without argument prints usage and exits with 1" {
  run ${REPO_ROOT}/lintpkg -E

  assert_line "Usage: lintpkg [options] <package_filename>"
  assert [ $status -eq 1 ]
}

@test "--extractdir without argument prints usage and exits with 1" {
  run ${REPO_ROOT}/lintpkg --extractdir

  assert_line "Usage: lintpkg [options] <package_filename>"
  assert [ $status -eq 1 ]
}

@test "-x without argument prints usage and exits with 1" {
  run ${REPO_ROOT}/lintpkg -x

  assert_line "Usage: lintpkg [options] <package_filename>"
  assert [ $status -eq 1 ]
}

@test "--exclude without argument prints usage and exits with 1" {
  run ${REPO_ROOT}/lintpkg --exclude

  assert_line "Usage: lintpkg [options] <package_filename>"
  assert [ $status -eq 1 ]
}

@test "Option followed by another option instead of argument prints usage and exits with 1" {
  run ${REPO_ROOT}/lintpkg -C -i

  assert_line "Usage: lintpkg [options] <package_filename>"
  assert [ $status -eq 1 ]
}
