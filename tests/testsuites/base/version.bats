#!/usr/bin/env bats

TESTSUITE="base"

@test "[$TESTSUITE] Printing version returns success" {
  run lintpkg -V

  [ $status -eq 0 ]
}

@test "[$TESTSUITE] -V prints version" {
  run lintpkg -V

  [[ $output == "lintpkg version 0.9.0" ]]
}

@test "[$TESTSUITE] --version prints version" {
  run lintpkg --version

  [[ $output == "lintpkg version 0.9.0" ]]
}
