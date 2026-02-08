#!/usr/bin/env bats

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Calling lintpkg with relative path to package" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)
  PKG=$(basename $PKG)

  cd /tmp
    run lintpkg -C "$TEST_CHECKS/logging" "$PKG"
  cd -

  assert_line "1 packages checked; 3 errors and 3 warnings."

  rm -f "$PKG"
  rm -rf "$BASE"
}
