#!/usr/bin/env bats

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Logging warning without info" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_warning_check "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: W: simple-warning /path/to/file"
  assert_line -n 1 "1 packages checked; 0 errors and 1 warnings."

  rm -f "$PKG"
}

@test "Logging warning with info" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_warning_check -i "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: W: simple-warning /path/to/file"
  assert_line -n 1 "A warning for a simple path"
  assert_line -n 2 "1 packages checked; 0 errors and 1 warnings."

  rm -f "$PKG"
}

@test "Logging warning for path with whitespaces without info" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_whitespace_warning_check "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: W: whitespace-warning /path/t o/a file"
  assert_line -n 1 "1 packages checked; 0 errors and 1 warnings."

  rm -f "$PKG"
}

@test "Logging warning for path with whitespaces with info" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_whitespace_warning_check -i "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: W: whitespace-warning /path/t o/a file"
  assert_line -n 1 "A warning for a path containing whitespaces"
  assert_line -n 2 "1 packages checked; 0 errors and 1 warnings."

  rm -f "$PKG"
}

@test "Logging warning ignored with -x does not print message" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_warning_check -x simple-warning "$PKG"

  assert_line -n 0 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging warning ignored with --exclude does not print message" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_warning_check --exclude simple-warning "$PKG"

  assert_line -n 0 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging warning ignored with -x does not print info message" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_warning_check -x simple-warning -i "$PKG"

  assert_line -n 0 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging warning ignored with --exclude does not print info message" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_warning_check --exclude simple-warning -i "$PKG"

  assert_line -n 0 "1 packages checked; 0 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logging warning removes working directory prefix from path" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_workingdir_warning_check "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1: W: working-dir-warning /usr/bin/foo"
  assert_line -n 1 "1 packages checked; 0 errors and 1 warnings."

  rm -f "$PKG"
}
