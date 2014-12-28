#!/usr/bin/env bats

load ../../helpers/locations

@test "showing explanation for message identifiers exits with 0" {
  run lintpkg -C "$TEST_CHECKS/logging" -I simple-notice

  [ $status -eq 0 ]
}

@test "-I shows explanation for message identifier" {
  run lintpkg -C "$TEST_CHECKS/logging" -I simple-notice

  [ "${lines[0]}" == "simple-notice:" ]
  [ "${lines[1]}" == "A notice for a simple path" ]
}

@test "--explain shows explanation for message identifier" {
  run lintpkg -C "$TEST_CHECKS/logging" --explain simple-notice

  [ "${lines[0]}" == "simple-notice:" ]
  [ "${lines[1]}" == "A notice for a simple path" ]
}

@test "show explanation for external-compression-utility-missing error" {
  run lintpkg --explain external-compression-utility-missing

  [ "${lines[0]}" == "external-compression-utility-missing:" ]
  [ "${lines[1]}" == "The necessary compression utility for uncompressing the package is missing." ]
}
