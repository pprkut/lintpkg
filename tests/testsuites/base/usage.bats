#!/usr/bin/env bats

TESTSUITE="base"

@test "[$TESTSUITE] Printing usage returns success" {
  run lintpkg -h

  [ $status -eq 0 ]
}

@test "[$TESTSUITE] -h prints usage" {
  run lintpkg -h

  [ "${lines[0]}" == "Usage: lintpkg [options] <package_filename>" ]
}

@test "[$TESTSUITE] --help prints usage" {
  run lintpkg --help

  [ "${lines[0]}" == "Usage: lintpkg [options] <package_filename>" ]
}

@test "[$TESTSUITE] Calling lintpkg with no argument prints usage" {
  run lintpkg

  [ "${lines[0]}" == "Usage: lintpkg [options] <package_filename>" ]
}
