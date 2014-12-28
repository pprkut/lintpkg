#!/usr/bin/env bats

load ../../helpers/locations
load ../../helpers/makepkg

@test "calling lintpkg with non-existing package prints error" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" "$PKG-foo"

  [ "${lines[0]}" == "(none): E: No package found with name /tmp/empty-1.0-noarch-1.tgz-foo" ]
  [ "${lines[1]}" == "0 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "calling lintpkg with one non-existing package skips package" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" "$PKG-foo" "$PKG"

  [ "${lines[0]}" == "(none): E: No package found with name /tmp/empty-1.0-noarch-1.tgz-foo" ]
  [ "${lines[10]}" == "1 packages checked; 3 errors and 3 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}
