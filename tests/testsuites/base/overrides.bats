#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  create_empty_package $BATS_TEST_TMPDIR/pkg
  mkdir -p $BATS_TEST_TMPDIR/system
}

# Ship the given overrides with the test package
package_overrides() {
  mkdir -p $BATS_TEST_TMPDIR/pkg/usr/share/lintpkg/overrides
  printf "$1" > $BATS_TEST_TMPDIR/pkg/usr/share/lintpkg/overrides/empty
}

# Provide the given overrides for the test package with lintpkg
system_overrides() {
  printf "$1" > $BATS_TEST_TMPDIR/system/empty
}

run_lintpkg() {
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR/pkg empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/overrides" --overridedir "$BATS_TEST_TMPDIR/system" "$@" "$PKG"

  rm -f "$PKG"
}

@test "Without overrides all messages are reported" {
  run_lintpkg

  expect_output "empty-1.0-noarch-1: E: path-error /usr/bin/foo"
  expect_output "empty-1.0-noarch-1: W: path-warning /usr/bin/foo slacker/root"
  expect_output "empty-1.0-noarch-1: I: path-notice /usr/bin/foo"
  expect_output "empty-1.0-noarch-1: E: subject-error hicolor"
  expect_output "empty-1.0-noarch-1: W: single-warning 12"
  expect_output "1 packages checked; 2 errors and 2 warnings."

  assert_expected_output
  assert [ $status -eq 64 ]
}

@test "Override from package hides message about path" {
  package_overrides "path-error /usr/bin/foo\n"

  run_lintpkg

  refute_line --partial "path-error"
  assert_line "1 packages checked; 1 errors and 2 warnings; 1 errors, 0 warnings and 0 notices overridden."
}

@test "Override for path ignores additional information of message" {
  package_overrides "path-warning /usr/bin/foo\n"

  run_lintpkg

  refute_line --partial "path-warning"
  assert_line "1 packages checked; 2 errors and 1 warnings; 0 errors, 1 warnings and 0 notices overridden."
}

@test "Override for path matches normalized path" {
  package_overrides "path-error usr/bin/foo/\n"

  run_lintpkg

  refute_line --partial "path-error"
}

@test "Override for path does not match other path" {
  package_overrides "path-error /usr/bin/bar\n"

  run_lintpkg

  assert_line "empty-1.0-noarch-1: E: path-error /usr/bin/foo"
}

@test "Override without path does not match message about path" {
  package_overrides "path-error\n"

  run_lintpkg

  assert_line "empty-1.0-noarch-1: E: path-error /usr/bin/foo"
  assert_line "empty-1.0-noarch-1: E: unused-override path-error"
  assert_line "1 packages checked; 3 errors and 2 warnings."
}

@test "Override for other message identifier does not match" {
  package_overrides "path-warning /usr/bin/foo\n"

  run_lintpkg

  assert_line "empty-1.0-noarch-1: E: path-error /usr/bin/foo"
}

@test "Override hides notice" {
  package_overrides "path-notice /usr/bin/foo\n"

  run_lintpkg

  refute_line --partial "path-notice"
  assert_line "1 packages checked; 2 errors and 2 warnings; 0 errors, 0 warnings and 1 notices overridden."
}

@test "Override with argument matches message with same first argument" {
  package_overrides "subject-error hicolor\n"

  run_lintpkg

  refute_line --partial "subject-error"
}

@test "Override with argument does not match message with other first argument" {
  package_overrides "subject-error gnome\n"

  run_lintpkg

  assert_line "empty-1.0-noarch-1: E: subject-error hicolor"
}

@test "Override without argument matches message with any argument" {
  package_overrides "single-warning\n"

  run_lintpkg

  refute_line --partial "single-warning"
}

@test "Overriding all errors and warnings exits with 0" {
  package_overrides "path-error /usr/bin/foo\npath-warning /usr/bin/foo\nsubject-error hicolor\nsingle-warning\n"

  run_lintpkg

  expect_output "empty-1.0-noarch-1: I: path-notice /usr/bin/foo"
  expect_output "1 packages checked; 0 errors and 0 warnings; 2 errors, 2 warnings and 0 notices overridden."

  assert_expected_output
  assert_success
}

@test "Comments, empty lines and whitespace in overrides are ignored" {
  package_overrides "# A reason\n  path-error   /usr/bin/foo  \n\n\t# Another reason\nsingle-warning\n"

  run_lintpkg

  refute_line --partial "path-error"
  refute_line --partial "single-warning"
}

@test "Overrides without trailing newline are read" {
  package_overrides "path-error /usr/bin/foo"

  run_lintpkg

  refute_line --partial "path-error"
}

@test "Override for path with whitespace" {
  mkdir -p "$BATS_TEST_TMPDIR/pkg/usr/t o"
  package_overrides "path-error /usr/t o/a file\n"
  cat > "$BATS_TEST_TMPDIR/check.sh" <<'CHECK'
check() {
  log_path_error "path-error" "usr/t o/a file"
}
CHECK
  mkdir -p "$BATS_TEST_TMPDIR/checks" && mv "$BATS_TEST_TMPDIR/check.sh" "$BATS_TEST_TMPDIR/checks/"
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR/pkg empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$BATS_TEST_TMPDIR/checks" "$PKG"

  assert_output "1 packages checked; 0 errors and 0 warnings; 1 errors, 0 warnings and 0 notices overridden."

  rm -f "$PKG"
}

@test "Override from lintpkg is used if package ships none" {
  system_overrides "path-error /usr/bin/foo\n"

  run_lintpkg

  refute_line --partial "path-error"
}

@test "Override from package replaces overrides from lintpkg" {
  system_overrides "path-error /usr/bin/foo\n"
  package_overrides "single-warning\n"

  run_lintpkg

  assert_line "empty-1.0-noarch-1: E: path-error /usr/bin/foo"
  refute_line --partial "single-warning"
}

@test "Empty overrides from package replace overrides from lintpkg" {
  system_overrides "path-error /usr/bin/foo\n"
  package_overrides ""

  run_lintpkg

  assert_line "empty-1.0-noarch-1: E: path-error /usr/bin/foo"
}

@test "Overrides from lintpkg are looked up by package name" {
  printf "path-error /usr/bin/foo\n" > $BATS_TEST_TMPDIR/system/other

  run_lintpkg

  assert_line "empty-1.0-noarch-1: E: path-error /usr/bin/foo"
}

@test "Overrides are only applied to their package" {
  package_overrides "path-error /usr/bin/foo\n"
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR/pkg empty 1.0 noarch 1)
  create_empty_package $BATS_TEST_TMPDIR/other
  OTHER=$(create_slackware_package $BATS_TEST_TMPDIR/other other 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/overrides" --overridedir "$BATS_TEST_TMPDIR/system" "$PKG" "$OTHER"

  refute_line "empty-1.0-noarch-1: E: path-error /usr/bin/foo"
  assert_line "other-1.0-noarch-1: E: path-error /usr/bin/foo"
  assert_line "2 packages checked; 3 errors and 4 warnings; 1 errors, 0 warnings and 0 notices overridden."

  rm -f "$PKG" "$OTHER"
}

@test "Excluded message is not counted as overridden" {
  package_overrides "path-error /usr/bin/foo\n"

  run_lintpkg -x path-error

  refute_line --partial "path-error"
  assert_line "1 packages checked; 1 errors and 2 warnings."
}

@test "Overrides are loaded from the default location next to lintpkg" {
  mkdir -p "$BATS_TEST_TMPDIR/app/checks" "$BATS_TEST_TMPDIR/app/overrides"
  cp ${REPO_ROOT}/lintpkg "$BATS_TEST_TMPDIR/app/"
  cp "$TEST_CHECKS/overrides/override_check.sh" "$BATS_TEST_TMPDIR/app/checks/"
  printf "path-error /usr/bin/foo\n" > "$BATS_TEST_TMPDIR/app/overrides/empty"
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR/pkg empty 1.0 noarch 1)

  run "$BATS_TEST_TMPDIR/app/lintpkg" "$PKG"

  refute_line --partial "path-error"

  rm -f "$PKG"
}

@test "--overridedir with non-existent directory prints error and exits with 1" {
  run ${REPO_ROOT}/lintpkg --overridedir "$BATS_TEST_TMPDIR/non_existent"

  assert_output "Directory does not exist: $BATS_TEST_TMPDIR/non_existent"
  assert [ $status -eq 1 ]
}

@test "--show-overrides shows overridden message with reason" {
  package_overrides "# Needed for debugging\npath-error /usr/bin/foo\n"

  run_lintpkg --show-overrides

  assert_line -n 0 "empty-1.0-noarch-1: O: path-error /usr/bin/foo"
  assert_line -n 1 "  Overridden by package: Needed for debugging"
  assert_line "1 packages checked; 1 errors and 2 warnings; 1 errors, 0 warnings and 0 notices overridden."
}

@test "--show-overrides shows overridden message with additional information" {
  package_overrides "path-warning /usr/bin/foo\n"

  run_lintpkg --show-overrides

  assert_line -n 1 "empty-1.0-noarch-1: O: path-warning /usr/bin/foo slacker/root"
}

@test "--show-overrides shows overridden message without reason" {
  package_overrides "path-error /usr/bin/foo\n"

  run_lintpkg --show-overrides

  assert_line -n 0 "empty-1.0-noarch-1: O: path-error /usr/bin/foo"
  assert_line -n 1 "  Overridden by package"
}

@test "--show-overrides shows each overridden message with its own reason" {
  package_overrides "# Needed for debugging\npath-error /usr/bin/foo\npath-notice /usr/bin/foo\n\n# Known issue\nsubject-error hicolor\n\nsingle-warning\n"

  run_lintpkg --show-overrides

  expect_output "empty-1.0-noarch-1: O: path-error /usr/bin/foo"
  expect_output "  Overridden by package: Needed for debugging"
  expect_output "empty-1.0-noarch-1: W: path-warning /usr/bin/foo slacker/root"
  expect_output "empty-1.0-noarch-1: O: path-notice /usr/bin/foo"
  expect_output "  Overridden by package: Needed for debugging"
  expect_output "empty-1.0-noarch-1: O: subject-error hicolor"
  expect_output "  Overridden by package: Known issue"
  expect_output "empty-1.0-noarch-1: O: single-warning 12"
  expect_output "  Overridden by package"
  expect_output "1 packages checked; 0 errors and 1 warnings; 2 errors, 1 warnings and 1 notices overridden."

  assert_expected_output
}

@test "--show-overrides shows overrides from lintpkg" {
  system_overrides "# Known issue\npath-error /usr/bin/foo\n"

  run_lintpkg --show-overrides

  assert_line -n 1 "  Overridden by lintpkg: Known issue"
}

@test "--show-overrides still exits with 0 if all errors and warnings are overridden" {
  package_overrides "path-error /usr/bin/foo\npath-warning /usr/bin/foo\nsubject-error hicolor\nsingle-warning\n"

  run_lintpkg --show-overrides

  assert_success
}

@test "--show-overrides with info shows explanation after reason" {
  package_overrides "# Needed for debugging\npath-error /usr/bin/foo\n"

  run_lintpkg --show-overrides -i

  assert_line -n 0 "empty-1.0-noarch-1: O: path-error /usr/bin/foo"
  assert_line -n 1 "  Overridden by package: Needed for debugging"
  assert_line -n 2 "An error for a path within the package"
}

@test "Reason spanning multiple comment lines is joined" {
  package_overrides "# Needed for\n# debugging\npath-error /usr/bin/foo\n"

  run_lintpkg --show-overrides

  assert_line -n 1 "  Overridden by package: Needed for debugging"
}

@test "Reason is shown as written" {
  package_overrides "# Needed for debugging:\npath-error /usr/bin/foo\n"

  run_lintpkg --show-overrides

  assert_line -n 1 "  Overridden by package: Needed for debugging:"
}

@test "Reason applies to all directly following overrides" {
  package_overrides "# Known issue\nsubject-error hicolor\npath-error /usr/bin/foo\n"

  run_lintpkg --show-overrides

  assert_line -n 0 "empty-1.0-noarch-1: O: path-error /usr/bin/foo"
  assert_line -n 1 "  Overridden by package: Known issue"
}

@test "Empty line ends scope of reason" {
  package_overrides "# Known issue\nsubject-error hicolor\n\npath-error /usr/bin/foo\n"

  run_lintpkg --show-overrides

  assert_line -n 0 "empty-1.0-noarch-1: O: path-error /usr/bin/foo"
  assert_line -n 1 "  Overridden by package"
}

@test "New comment after overrides starts new reason" {
  package_overrides "# Known issue\nsubject-error hicolor\n# Needed for debugging\npath-error /usr/bin/foo\n"

  run_lintpkg --show-overrides

  assert_line -n 0 "empty-1.0-noarch-1: O: path-error /usr/bin/foo"
  assert_line -n 1 "  Overridden by package: Needed for debugging"
}

@test "Unused override is reported as error" {
  package_overrides "path-error /usr/bin/foo\npath-error /usr/bin/bar\nsingle-warning\nsubject-error gnome\n"

  run_lintpkg

  assert_line "empty-1.0-noarch-1: E: unused-override path-error /usr/bin/bar"
  assert_line "empty-1.0-noarch-1: E: unused-override subject-error gnome"
  refute_line --partial "unused-override single-warning"
  assert_line "1 packages checked; 3 errors and 1 warnings; 1 errors, 1 warnings and 0 notices overridden."
  assert [ $status -eq 64 ]
}

@test "Unused override is reported after the messages of the checks" {
  package_overrides "path-error /usr/bin/bar\n"

  run_lintpkg

  assert_line -n 5 "empty-1.0-noarch-1: E: unused-override path-error /usr/bin/bar"
}

@test "Unused override from lintpkg is reported" {
  system_overrides "path-error /usr/bin/bar\n"

  run_lintpkg

  assert_line "empty-1.0-noarch-1: E: unused-override path-error /usr/bin/bar"
}

@test "Second of duplicate overrides is reported as unused" {
  package_overrides "# First\npath-error /usr/bin/foo\n\n# Second\npath-error /usr/bin/foo\n"

  run_lintpkg --show-overrides

  assert_line -n 1 "  Overridden by package: First"
  assert_line "empty-1.0-noarch-1: E: unused-override path-error /usr/bin/foo"
}

@test "Override for excluded message is not reported as unused" {
  package_overrides "path-error /usr/bin/foo\n"

  run_lintpkg -x path-error

  refute_line --partial "unused-override"
}

@test "Unused override can't be excluded" {
  package_overrides "path-error /usr/bin/bar\n"

  run_lintpkg -x unused-override

  assert_line "empty-1.0-noarch-1: E: unused-override path-error /usr/bin/bar"
}

@test "Unused override can't be overridden" {
  package_overrides "path-error /usr/bin/bar\nunused-override path-error\n"

  run_lintpkg

  assert_line "empty-1.0-noarch-1: E: unused-override path-error /usr/bin/bar"
  assert_line "empty-1.0-noarch-1: E: unused-override unused-override path-error"
}

@test "--ignore-unused-overrides does not report unused overrides" {
  package_overrides "path-error /usr/bin/bar\n"

  run_lintpkg --ignore-unused-overrides

  refute_line --partial "unused-override"
  assert_line "1 packages checked; 2 errors and 2 warnings."
}

@test "Unused override with info shows explanation" {
  package_overrides "path-error /usr/bin/bar\n"

  run_lintpkg -i

  assert_line "empty-1.0-noarch-1: E: unused-override path-error /usr/bin/bar"
  assert_line --partial "The package has an override that didn't match any message."
}

@test "Explain unused-override" {
  run ${REPO_ROOT}/lintpkg -I unused-override

  assert_line -n 0 "unused-override:"
  assert_line -n 1 --partial "The package has an override that didn't match any message."
}
