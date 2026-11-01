#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2022  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/ownership_check.sh"
}

@test "Check logs error when incorrect owner for /bin" {
  create_empty_package "$BATS_TEST_TMPDIR"
  rm -rf "${BATS_TEST_TMPDIR:?}/usr"

  mkdir -p "$BATS_TEST_TMPDIR/bin"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/bin/s|root/root|slacker/root|")

  run check

  assert_output "path-error strange-owner-or-group bin/ slacker/root"
}

@test "Check logs error when incorrect owner for file in /bin" {
  create_empty_package "$BATS_TEST_TMPDIR"

  mkdir -p "$BATS_TEST_TMPDIR/bin"
  touch "$BATS_TEST_TMPDIR/bin/baz"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/bin\/baz/s|root/root|slacker/root|")

  run check

  assert_output "path-error strange-owner-or-group bin/baz slacker/root"
}

@test "Check logs error when incorrect owner for /lib" {
  create_empty_package "$BATS_TEST_TMPDIR"
  rm -rf "${BATS_TEST_TMPDIR:?}/lib"

  mkdir -p "$BATS_TEST_TMPDIR/lib"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/lib/s|root/root|slacker/root|")

  run check

  assert_output "path-error strange-owner-or-group lib/ slacker/root"
}

@test "Check logs error when incorrect owner for file in /lib" {
  create_empty_package "$BATS_TEST_TMPDIR"

  mkdir -p "$BATS_TEST_TMPDIR/lib"
  touch "$BATS_TEST_TMPDIR/lib/baz"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/lib\/baz/s|root/root|slacker/root|")

  run check

  assert_output "path-error strange-owner-or-group lib/baz slacker/root"
}

@test "Check logs error when incorrect owner for /lib64" {
  create_empty_package "$BATS_TEST_TMPDIR"
  rm -rf "${BATS_TEST_TMPDIR:?}/lib64"

  mkdir -p "$BATS_TEST_TMPDIR/lib64"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/lib64/s|root/root|slacker/root|")

  run check

  assert_output "path-error strange-owner-or-group lib64/ slacker/root"
}

@test "Check logs error when incorrect owner for file in /lib64" {
  create_empty_package "$BATS_TEST_TMPDIR"

  mkdir -p "$BATS_TEST_TMPDIR/lib64"
  touch "$BATS_TEST_TMPDIR/lib64/baz"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/lib64\/baz/s|root/root|slacker/root|")

  run check

  assert_output "path-error strange-owner-or-group lib64/baz slacker/root"
}

@test "Check logs error when incorrect owner for /sbin" {
  create_empty_package "$BATS_TEST_TMPDIR"
  rm -rf "${BATS_TEST_TMPDIR:?}/usr"

  mkdir -p "$BATS_TEST_TMPDIR/sbin"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/sbin/s|root/root|slacker/root|")

  run check

  assert_output "path-error strange-owner-or-group sbin/ slacker/root"
}

@test "Check logs error when incorrect owner for file in /sbin" {
  create_empty_package "$BATS_TEST_TMPDIR"

  mkdir -p "$BATS_TEST_TMPDIR/sbin"
  touch "$BATS_TEST_TMPDIR/sbin/baz"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/sbin\/baz/s|root/root|slacker/root|")

  run check

  assert_output "path-error strange-owner-or-group sbin/baz slacker/root"
}

@test "Check logs error when incorrect owner for /usr" {
  create_empty_package "$BATS_TEST_TMPDIR"
  rm -rf "${BATS_TEST_TMPDIR:?}/usr/bin"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/usr/s|root/root|slacker/root|")

  run check

  assert_output "path-error strange-owner-or-group usr/ slacker/root"
}

@test "Check logs error when incorrect owner for file in /usr" {
  create_empty_package "$BATS_TEST_TMPDIR"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/usr\/bin\/foo/s|root/root|slacker/root|")

  run check

  assert_output "path-error strange-owner-or-group usr/bin/foo slacker/root"
}

@test "Check logs error when incorrect owner for /" {
  create_empty_package "$BATS_TEST_TMPDIR"
  rm -rf "${BATS_TEST_TMPDIR:?}/usr"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/\.\//s|root/root|slacker/root|")

  run check

  assert_output "path-error strange-owner-or-group ./ slacker/root"
}

@test "Check logs error with link target when incorrect owner for symlink in /usr/bin" {
  create_empty_package "$BATS_TEST_TMPDIR"
  ln -s foo "$BATS_TEST_TMPDIR/usr/bin/bar"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/usr\/bin\/bar/s|root/root|slacker/root|")

  run check

  assert_output "path-error strange-owner-or-group usr/bin/bar -> foo slacker/root"
}

@test "Check logs error with link target when incorrect owner for symlink in /usr" {
  create_empty_package "$BATS_TEST_TMPDIR"
  mkdir -p "$BATS_TEST_TMPDIR/usr/lib"
  ln -s ../bin/foo "$BATS_TEST_TMPDIR/usr/lib/bar"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/usr\/lib\/bar/s|root/root|slacker/root|")

  run check

  assert_output "path-error strange-owner-or-group usr/lib/bar -> ../bin/foo slacker/root"
}

@test "Package listing shows link target for symlink with incorrect owner" {
  create_empty_package "$BATS_TEST_TMPDIR"
  ln -s foo "$BATS_TEST_TMPDIR/usr/bin/bar"
  PKG=$(MAKEPKG_OPTIONS="-l n" create_slackware_package "$BATS_TEST_TMPDIR" empty 1.0 noarch 1)

  run "${REPO_ROOT}/lintpkg" -c ownership_check "$PKG"

  assert_line "empty-1.0-noarch-1: E: strange-owner-or-group /usr/bin/bar -> foo $(whoami)/$(id -gn)"

  rm -f "$PKG"
}
