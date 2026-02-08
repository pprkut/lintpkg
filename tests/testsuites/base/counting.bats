#!/usr/bin/env bats

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Counting errors/warnings properly for single package" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" "$PKG"

  assert_line "1 packages checked; 3 errors and 3 warnings."

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Counting errors/warnings properly for multiple packages" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG1=$(create_slackware_package $BASE empty 1.0 noarch 1)
  PKG2=$(create_slackware_package $BASE lintpkg-empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" "$PKG1" "$PKG2"

  assert_line "2 packages checked; 6 errors and 6 warnings."

  rm -f "$PKG1"
  rm -f "$PKG2"
  rm -rf "$BASE"
}
