#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Checks don't affect later checks or lintpkg" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/isolation" "$PKG"

  assert_output "empty-1.0-noarch-1: W: isolated-warning
1 packages checked; 0 errors and 1 warnings."
  assert [ $status -eq 64 ]

  rm -f "$PKG"
}

@test "Messages logged from a pipeline are counted" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pipeline" "$PKG"

  expect_output "empty-1.0-noarch-1: E: pipeline-error /path/to/file"
  expect_output "empty-1.0-noarch-1: E: pipeline-error /path/to/other file"
  expect_output "empty-1.0-noarch-1: W: pipeline-warning /path/to/file"
  expect_output "1 packages checked; 2 errors and 1 warnings."

  assert_expected_output
  assert [ $status -eq 64 ]

  rm -f "$PKG"
}

@test "Overrides for messages logged from a pipeline are used" {
  create_empty_package $BATS_TEST_TMPDIR
  mkdir -p $BATS_TEST_TMPDIR/usr/share/lintpkg/overrides
  printf "pipeline-warning /path/to/file\n" > $BATS_TEST_TMPDIR/usr/share/lintpkg/overrides/empty
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pipeline" "$PKG"

  refute_line --partial "pipeline-warning"
  refute_line --partial "unused-override"
  assert_line "1 packages checked; 2 errors and 0 warnings; 0 errors, 1 warnings and 0 notices overridden."

  rm -f "$PKG"
}

@test "Checks only use local variables" {
  load ../../helpers/mock-loggers

  create_empty_package $BATS_TEST_TMPDIR
  mkdir -p $BATS_TEST_TMPDIR/tmp/foo $BATS_TEST_TMPDIR/etc
  mkdir -p $BATS_TEST_TMPDIR/usr/info $BATS_TEST_TMPDIR/usr/man/man1
  mkdir -p $BATS_TEST_TMPDIR/usr/lib $BATS_TEST_TMPDIR/usr/share/icons/hicolor
  touch $BATS_TEST_TMPDIR/usr/info/foo.info $BATS_TEST_TMPDIR/usr/man/man1/foo.1
  touch $BATS_TEST_TMPDIR/usr/lib/libfoo.la
  ln -s foo $BATS_TEST_TMPDIR/usr/bin/bar

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_NAME="empty"
  PKG_ARCH="x86_64"
  PKG_LISTING="./"
  PKG_DETAILED_LISTING="-rwxr-xr-x slacker/users 0 2026-01-01 00:00 usr/bin/foo"

  # Run each check like lintpkg does, and list the variables it leaves behind.
  # before is defined up front, so that it isn't listed itself:
  leaked=""
  before=""

  for check in "$LIVE_CHECKS"/*_check.sh; do
    output=$(
      source "$check"
      before=$(compgen -v | sort)
      check > /dev/null 2>&1
      comm -13 <(echo "$before") <(compgen -v | sort) | sed "s|^|${check##*/}: |"
    )

    if [ -n "$output" ]; then
      leaked+="$output"$'\n'
    fi
  done

  assert_equal "$leaked" ""
}
