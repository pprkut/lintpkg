#!/usr/bin/env bats

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Calling lintpkg with relative path to package" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)
  PKG=$(basename $PKG)

  cd /tmp
    run lintpkg -C "$TEST_CHECKS/logging" "$PKG"
  cd -

  assert_line "1 packages checked; 3 errors and 3 warnings."

  rm -f "$PKG"
}
