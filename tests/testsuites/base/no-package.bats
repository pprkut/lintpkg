#!/usr/bin/env bats

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Calling lintpkg with non-existing package prints error" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" "$PKG-foo"

  assert_line "(none): E: No package found with name /tmp/empty-1.0-noarch-1.tgz-foo"
  assert_line "0 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Calling lintpkg with one non-existing package skips package" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" "$PKG-foo" "$PKG"

  assert_line "(none): E: No package found with name /tmp/empty-1.0-noarch-1.tgz-foo"
  assert_line "1 packages checked; 3 errors and 3 warnings."

  rm -f "$PKG"
}
