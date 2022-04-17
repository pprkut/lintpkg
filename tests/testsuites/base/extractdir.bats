#!/usr/bin/env bats

TESTSUITE="base"

load ../../helpers/locations
load ../../helpers/makepkg

@test "[$TESTSUITE] Setting extraction directory to non-existant path exits with 0" {
  run lintpkg -E "$TEST_CHECKS/non_existant"

  [ $status -eq 0 ]
}

@test "[$TESTSUITE] -E with non-existant directory prints error" {
  run lintpkg -E "$TEST_CHECKS/non_existant"

  [ "${lines[0]}" == "Directory does not exist: $TEST_CHECKS/non_existant" ]
}

@test "[$TESTSUITE] --extractdir with non-existant directory prints error" {
  run lintpkg --extractdir "$TEST_CHECKS/non_existant"

  [ "${lines[0]}" == "Directory does not exist: $TEST_CHECKS/non_existant" ]
}

@test "[$TESTSUITE] Setting extraction directory to non-writeable path exits with 1" {
  mkdir -p /tmp/lintpkg_test_not_writeable
  chmod -w /tmp/lintpkg_test_not_writeable

  run lintpkg -E "/tmp/lintpkg_test_not_writeable"

  [ $status -eq 1 ]

  rmdir /tmp/lintpkg_test_not_writeable
}

@test "[$TESTSUITE] -E with non-writeable directory prints error" {
  mkdir -p /tmp/lintpkg_test_not_writeable
  chmod -w /tmp/lintpkg_test_not_writeable

  run lintpkg -E "/tmp/lintpkg_test_not_writeable"

  [ "${lines[0]}" == "Couldn't create temporary directory" ]

  rmdir /tmp/lintpkg_test_not_writeable
}

@test "[$TESTSUITE] --extractdir with non-writeable directory prints error" {
  mkdir -p /tmp/lintpkg_test_not_writeable
  chmod -w /tmp/lintpkg_test_not_writeable

  run lintpkg --extractdir "/tmp/lintpkg_test_not_writeable"

  [ "${lines[0]}" == "Couldn't create temporary directory" ]

  rmdir /tmp/lintpkg_test_not_writeable
}

@test "[$TESTSUITE] Lintpkg extracts package inside extraction directory" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  mkdir -p /tmp/lintpkg_test

  run lintpkg --extractdir "/tmp/lintpkg_test" "$PKG"

  [ -e "$BASE/install/slack-desc" ]
  [ -e "$BASE/usr/bin/foo" ]

  rm -f "$PKG"
  rm -rf /tmp/lintpkg_test
}
