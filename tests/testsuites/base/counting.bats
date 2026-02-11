#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Counting errors/warnings properly for single package" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/logging" "$PKG"

  assert_line "1 packages checked; 3 errors and 3 warnings."

  rm -f "$PKG"
}

@test "Counting errors/warnings properly for multiple packages" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG1=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)
  PKG2=$(create_slackware_package $BATS_TEST_TMPDIR lintpkg-empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/logging" "$PKG1" "$PKG2"

  assert_line "2 packages checked; 6 errors and 6 warnings."

  rm -f "$PKG1"
  rm -f "$PKG2"
}
