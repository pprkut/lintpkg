#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

assert_package_listing() {
  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_listing_check "$1"

  expect_output "./"
  expect_output "install/"
  expect_output "install/slack-desc"
  expect_output "usr/"
  expect_output "usr/bin/"
  expect_output "usr/bin/foo"

  assert_expected_output --partial
}

assert_package_extracted() {
  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/extraction" -c extracted_files_check "$1"

  assert_line -n 0 "."
  assert_line -n 1 "./install"
  assert_line -n 2 "./install/slack-desc"
  assert_line -n 3 "./usr"
  assert_line -n 4 "./usr/bin"
  assert_line -n 5 "./usr/bin/foo"
}

@test "Lists gzip compressed packages" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1 tgz)

  assert_package_listing "$PKG"

  rm -f "$PKG"
}

@test "Extracts gzip compressed packages" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1 tgz)

  assert_package_extracted "$PKG"

  rm -f "$PKG"
}

@test "Lists bzip2 compressed packages" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1 tbz)

  assert_package_listing "$PKG"

  rm -f "$PKG"
}

@test "Extracts bzip2 compressed packages" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1 tbz)

  assert_package_extracted "$PKG"

  rm -f "$PKG"
}

@test "Lists xz compressed packages" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1 txz)

  assert_package_listing "$PKG"

  rm -f "$PKG"
}

@test "Extracts xz compressed packages" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1 txz)

  assert_package_extracted "$PKG"

  rm -f "$PKG"
}
