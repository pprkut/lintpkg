#!/usr/bin/env bats

@test "printing usage returns success" {
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

@test "calling lintpkg with no argument prints usage" {
  run lintpkg

  [ "${lines[0]}" == "Usage: lintpkg [options] <package_filename>" ]
}
