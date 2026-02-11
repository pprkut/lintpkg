#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2022  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Checks have proper full package name" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_fullname_check "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1"

  rm -f "$PKG"
}

@test "Checks have proper simple package name" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_name_check "$PKG"

  assert_line -n 0 "empty"

  rm -f "$PKG"
}

@test "Checks have proper package name with dash" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR lintpkg-empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_name_check "$PKG"

  assert_line -n 0 "lintpkg-empty"

  rm -f "$PKG"
}

@test "Checks have proper package name when version has dash" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR lintpkg-empty 1.0-1 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_name_check "$PKG"

  assert_line -n 0 "lintpkg-empty-1.0"

  rm -f "$PKG"
}

@test "Checks have proper simple package version" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_version_check "$PKG"

  assert_line -n 0 "1.0"

  rm -f "$PKG"
}

@test "Checks have proper package version when name has dash" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR lintpkg-empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_version_check "$PKG"

  assert_line -n 0 "1.0"

  rm -f "$PKG"
}

@test "Checks have proper package version when version has dash" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR lintpkg-empty 1.0-1 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_version_check "$PKG"

  assert_line -n 0 "1"

  rm -f "$PKG"
}

@test "Checks have proper package architecture" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_arch_check "$PKG"

  assert_line -n 0 "noarch"

  rm -f "$PKG"
}

@test "Checks have proper package build number" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 2)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_build_check "$PKG"

  assert_line -n 0 "2"

  rm -f "$PKG"
}

@test "Checks have proper package extension" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_extension_check "$PKG"

  assert_line -n 0 "tgz"

  rm -f "$PKG"
}

@test "Checks have proper simple package listing" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_listing_check "$PKG"

  expect_output "./"
  expect_output "install/"
  expect_output "install/slack-desc"
  expect_output "usr/"
  expect_output "usr/bin/"
  expect_output "usr/bin/foo"

  assert_expected_output --partial

  rm -f "$PKG"
}

@test "Checks have proper detailed package listing" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  USER=$(id -u -n)
  GROUP=$(id -g -n)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_detailed_listing_check "$PKG"

  perm_dir='drwxr-xr-x'
  perm_file='-rw-r--r--'
  perm_exec='-rwxr-xr-x'
  owner="$USER/$GROUP"
  date='[0-9]{4}-[0-9]{2}-[0-9]{2}'
  time='[0-9]{2}:[0-9]{2}'
  whitespace='[[:blank:]]+'

  assert_line --index 0 --regexp "$perm_dir $owner${whitespace}0 $date $time ./"
  assert_line --index 1 --regexp "$perm_dir $owner${whitespace}0 $date $time install/"
  assert_line --index 2 --regexp "$perm_file $owner${whitespace}141 $date $time install/slack-desc"
  assert_line --index 3 --regexp "$perm_dir $owner${whitespace}0 $date $time usr/"
  assert_line --index 4 --regexp "$perm_dir $owner${whitespace}0 $date $time usr/bin/"
  assert_line --index 5 --regexp "$perm_exec $owner${whitespace}0 $date $time usr/bin/foo"

  rm -f "$PKG"
}

@test "Checks have default working directory" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_working_dir_check "$PKG"

  assert_line -n 0 --regexp '^/tmp/lintpkg\.......$'

  rm -f "$PKG"
}

@test "Checks have working directory specified with -E" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  mkdir -p /tmp/lintpkg_test

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_working_dir_check -E "/tmp/lintpkg_test" "$PKG"

  assert_line -n 0 --regexp '^/tmp/lintpkg_test/lintpkg\.......$'

  rm -f "$PKG"
  rm -rf /tmp/lintpkg_test
}

@test "Checks have working directory specified with --extractdir" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  mkdir -p /tmp/lintpkg_test

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_working_dir_check --extractdir "/tmp/lintpkg_test" "$PKG"

  assert_line -n 0 --regexp '^/tmp/lintpkg_test/lintpkg\.......$'

  rm -f "$PKG"
  rm -rf /tmp/lintpkg_test
}
