#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "-i for message of check without explanations shows no explanation" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/no_info" -i "$PKG"

  expect_output "empty-1.0-noarch-1: E: explained-error /path/to/file"
  expect_output "An error with an explanation"
  expect_output ""
  expect_output "empty-1.0-noarch-1: E: unexplained-error /path/to/file"
  expect_output "1 packages checked; 2 errors and 0 warnings."

  assert_expected_output

  rm -f "$PKG"
}

@test "-i for message of lintpkg after running checks shows no unrelated explanation" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/logging" -c log_error_check -i "$PKG" "$PKG-foo"

  expect_output "empty-1.0-noarch-1: E: simple-error /path/to/file"
  expect_output "A error for a simple path"
  expect_output ""
  expect_output "(none): E: No package found with name $PKG-foo"
  expect_output "1 packages checked; 1 errors and 0 warnings."

  assert_expected_output

  rm -f "$PKG"
}

@test "-i explains missing compression utility after running checks" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)
  TBZ=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 2 tbz)

  # Make bzip2 and lbzip2 unusable
  mkdir -p "$BATS_TEST_TMPDIR/bin"
  printf '#!/bin/sh\nexit 1\n' > "$BATS_TEST_TMPDIR/bin/bzip2"
  chmod +x "$BATS_TEST_TMPDIR/bin/bzip2"
  cp "$BATS_TEST_TMPDIR/bin/bzip2" "$BATS_TEST_TMPDIR/bin/lbzip2"

  PATH="$BATS_TEST_TMPDIR/bin:$PATH" run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/logging" -c log_error_check -i "$PKG" "$TBZ"

  expect_output "empty-1.0-noarch-1: E: simple-error /path/to/file"
  expect_output "A error for a simple path"
  expect_output ""
  expect_output "empty-1.0-noarch-2: I: external-compression-utility-missing lbzip2"
  expect_output "The necessary compression utility for uncompressing the package is missing."
  expect_output ""
  expect_output "1 packages checked; 1 errors and 0 warnings."

  assert_expected_output

  rm -f "$PKG" "$TBZ"
}
