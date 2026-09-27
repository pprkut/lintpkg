#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Extracts extended attributes" {
  create_empty_package $BATS_TEST_TMPDIR

  if ! setfattr -n user.lintpkg -v test $BATS_TEST_TMPDIR/usr/bin/foo 2> /dev/null; then
    skip "Extended attributes are not supported"
  fi

  PKG=$(MAKEPKG_OPTIONS="--xattrs" create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/extraction" -c extracted_attributes_check "$PKG"

  assert_line -n 0 "xattr: test"

  rm -f "$PKG"
}

@test "Extracts ACLs" {
  create_empty_package $BATS_TEST_TMPDIR

  if ! setfacl -m u:nobody:r $BATS_TEST_TMPDIR/usr/bin/foo 2> /dev/null; then
    skip "ACLs are not supported"
  fi

  PKG=$(MAKEPKG_OPTIONS="--acls" create_slackware_package $BATS_TEST_TMPDIR empty 1.0 noarch 1)

  run ${REPO_ROOT}/lintpkg -C "$TEST_CHECKS/extraction" -c extracted_attributes_check "$PKG"

  assert_line -n 1 "acl: user:nobody:r--"

  rm -f "$PKG"
}
