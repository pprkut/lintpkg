#!/usr/bin/env bats

TESTSUITE="base"

load ../../helpers/locations
load ../../helpers/makepkg

@test "[$TESTSUITE] Calling lintpkg with relative path to package" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)
  PKG=$(basename $PKG)

  cd /tmp
    run lintpkg -C "$TEST_CHECKS/logging" "$PKG"
  cd -

  [ "${lines[9]}" == "1 packages checked; 3 errors and 3 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}
