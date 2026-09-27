#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Logs error for package with corrupt compression" {
  create_empty_package $BATS_TEST_TMPDIR
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1 txz)

  head -c 100 "$PKG" > "$BATS_TEST_TMPDIR/empty-1.0-noarch-1.txz"

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_fullname_check "$BATS_TEST_TMPDIR/empty-1.0-noarch-1.txz"

  assert_failure 64
  assert_line -n 0 --partial "(none): E: error while reading $BATS_TEST_TMPDIR/empty-1.0-noarch-1.txz: xz: "
  assert_line -n 1 "0 packages checked; 1 errors and 0 warnings."

  rm -f "$PKG"
}

@test "Logs error for package without tar archive" {
  echo "not a tar archive" | gzip > "$BATS_TEST_TMPDIR/empty-1.0-noarch-1.tgz"

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_fullname_check "$BATS_TEST_TMPDIR/empty-1.0-noarch-1.tgz"

  assert_failure 64
  assert_line -n 0 --partial "(none): E: error while reading $BATS_TEST_TMPDIR/empty-1.0-noarch-1.tgz: tar: "
  assert_line -n 1 "0 packages checked; 1 errors and 0 warnings."
}

@test "Logs error for empty package" {
  touch "$BATS_TEST_TMPDIR/empty-1.0-noarch-1.txz"

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_fullname_check "$BATS_TEST_TMPDIR/empty-1.0-noarch-1.txz"

  assert_failure 64
  assert_line -n 0 --partial "(none): E: error while reading $BATS_TEST_TMPDIR/empty-1.0-noarch-1.txz: xz: "
  assert_line -n 1 "0 packages checked; 1 errors and 0 warnings."
}

@test "Logs error with absolute path for package given with relative path" {
  touch "$BATS_TEST_TMPDIR/empty-1.0-noarch-1.txz"

  cd "$BATS_TEST_TMPDIR"

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_fullname_check empty-1.0-noarch-1.txz

  assert_line -n 0 --partial "(none): E: error while reading $BATS_TEST_TMPDIR/empty-1.0-noarch-1.txz: xz: "
}

@test "Checks the next package after a package that can't be read" {
  touch "$BATS_TEST_TMPDIR/broken-1.0-noarch-1.txz"

  create_empty_package $BATS_TEST_TMPDIR/package
  PKG=$(create_slackware_package $BATS_TEST_TMPDIR/package empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_fullname_check "$BATS_TEST_TMPDIR/broken-1.0-noarch-1.txz" "$PKG"

  assert_line -n 0 --partial "(none): E: error while reading $BATS_TEST_TMPDIR/broken-1.0-noarch-1.txz: "
  assert_line -n 1 "empty-1.0-noarch-1"
  assert_line -n 2 "1 packages checked; 1 errors and 0 warnings."

  rm -f "$PKG"
}
