#!/usr/bin/env bats

@test "printing version returns success" {
  run lintpkg -V

  [ $status -eq 0 ]
}

@test "-V prints version" {
  run lintpkg -V

  [ $output == "lintpkg version 0.9.0" ]
}

@test "--version prints version" {
  run lintpkg --version

  [ $output == "lintpkg version 0.9.0" ]
}
