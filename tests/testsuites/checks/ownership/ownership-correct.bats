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

@test "Check logs no error when correct owner and group for /bin" {
  create_empty_package "$BATS_TEST_TMPDIR"
  rm -rf "${BATS_TEST_TMPDIR:?}/usr"

  mkdir -p "$BATS_TEST_TMPDIR/bin"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g")

  run check

  refute_output
}

@test "Check logs no error when correct owner and group for file in /bin" {
  create_empty_package "$BATS_TEST_TMPDIR"

  mkdir -p "$BATS_TEST_TMPDIR/bin"
  touch "$BATS_TEST_TMPDIR/bin/foo"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g")

  run check

  refute_output
}

@test "Check logs no error when correct owner and group for /lib" {
  create_empty_package "$BATS_TEST_TMPDIR"
  rm -rf "${BATS_TEST_TMPDIR:?}/lib"

  mkdir -p "$BATS_TEST_TMPDIR/lib"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g")

  run check

  refute_output
}

@test "Check logs no error when correct owner and group for file in /lib" {
  create_empty_package "$BATS_TEST_TMPDIR"

  mkdir -p "$BATS_TEST_TMPDIR/lib"
  touch "$BATS_TEST_TMPDIR/lib/baz"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g")

  run check

  refute_output
}

@test "Check logs no error when correct owner and group for /lib64" {
  create_empty_package "$BATS_TEST_TMPDIR"
  rm -rf "${BATS_TEST_TMPDIR:?}/lib64"

  mkdir -p "$BATS_TEST_TMPDIR/lib64"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g")

  run check

  refute_output
}

@test "Check logs no error when correct owner and group for file in /lib64" {
  create_empty_package "$BATS_TEST_TMPDIR"

  mkdir -p "$BATS_TEST_TMPDIR/lib64"
  touch "$BATS_TEST_TMPDIR/lib64/baz"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g")

  run check

  refute_output
}

@test "Check logs no error when correct owner and group for /sbin" {
  create_empty_package "$BATS_TEST_TMPDIR"
  rm -rf "${BATS_TEST_TMPDIR:?}/usr"

  mkdir -p "$BATS_TEST_TMPDIR/sbin"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g")

  run check

  refute_output
}

@test "Check logs no error when correct owner and group for file in /sbin" {
  create_empty_package "$BATS_TEST_TMPDIR"

  mkdir -p "$BATS_TEST_TMPDIR/sbin"
  touch "$BATS_TEST_TMPDIR/sbin/baz"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g")

  run check

  refute_output
}

@test "Check logs no error when correct owner and group for /usr" {
  create_empty_package "$BATS_TEST_TMPDIR"
  rm -rf "${BATS_TEST_TMPDIR:?}/usr/bin"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g")

  run check

  refute_output
}

@test "Check logs no error when correct owner and group for file in /usr" {
  create_empty_package "$BATS_TEST_TMPDIR"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g")

  run check

  refute_output
}

@test "Check logs no error when correct owner and group for /" {
  create_empty_package "$BATS_TEST_TMPDIR"
  rm -rf "${BATS_TEST_TMPDIR:?}/usr"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g")

  run check

  refute_output
}

@test "Check logs no error when owner is whitelisted (daemon) for file in /usr/bin" {
  create_empty_package "$BATS_TEST_TMPDIR"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/usr\/bin\/foo/s|root/root|daemon/daemon|g")

  run check

  refute_output
}

@test "Check logs no error when owner is whitelisted (uucp) for file in /usr/bin" {
  create_empty_package "$BATS_TEST_TMPDIR"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/usr\/bin\/foo/s|root/root|uucp/uucp|g")

  run check

  refute_output
}

@test "Check logs no error when owner is whitelisted (daemon) for file in /usr/sbin" {
  create_empty_package "$BATS_TEST_TMPDIR"
  mv "$BATS_TEST_TMPDIR/usr/bin" "$BATS_TEST_TMPDIR/usr/sbin"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/usr\/sbin\/foo/s|root/root|daemon/daemon|g")

  run check

  refute_output
}

@test "Check logs no error when owner is whitelisted (uucp) for file in /usr/sbin" {
  create_empty_package "$BATS_TEST_TMPDIR"
  mv "$BATS_TEST_TMPDIR/usr/bin" "$BATS_TEST_TMPDIR/usr/sbin"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/usr\/sbin\/foo/s|root/root|uucp/uucp|g")

  run check

  refute_output
}

@test "Check logs no error when owner is whitelisted (daemon) for symlink with path as target in /usr/bin" {
  create_empty_package "$BATS_TEST_TMPDIR"
  ln -s ../lib/foo "$BATS_TEST_TMPDIR/usr/bin/bar"

  PKG_DETAILED_LISTING=$(create_detailed_tar_listing "$BATS_TEST_TMPDIR" | sed "s|$(whoami)/$(id -gn)|root/root|g" | sed "/usr\/bin\/bar/s|root/root|daemon/daemon|g")

  run check

  refute_output
}
