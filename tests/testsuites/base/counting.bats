#!/usr/bin/env bats

TESTSUITE="base"

load ../../helpers/locations
load ../../helpers/makepkg

@test "[$TESTSUITE] Counting errors/warnings properly for single package" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" "$PKG"

  [ "${lines[9]}" == "1 packages checked; 3 errors and 3 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "[$TESTSUITE] Counting errors/warnings properly for multiple packages" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG1=$(create_slackware_package $BASE empty 1.0 noarch 1)
  PKG2=$(create_slackware_package $BASE lintpkg-empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" "$PKG1" "$PKG2"

  [ "${lines[18]}" == "2 packages checked; 6 errors and 6 warnings." ]

  rm -f "$PKG1"
  rm -f "$PKG2"
  rm -rf "$BASE"
}
