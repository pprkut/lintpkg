#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2022  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/architecture_check.sh"
}

@test "Check logs no error when x86 64-bit library in /usr/lib64" {
  create_empty_package "$BATS_TEST_TMPDIR"

  mkdir -p "$BATS_TEST_TMPDIR/usr/lib64"
  cp "$TEST_STATICS/binaries/libhello-x86_64-stripped.so" "$BATS_TEST_TMPDIR/usr/lib64/"

  create_file_types "$BATS_TEST_TMPDIR"
  PKG_ARCH=x86_64

  run check

  refute_output
}

@test "Check logs no error when x86 32-bit library in /usr/lib for i486 package" {
  create_empty_package "$BATS_TEST_TMPDIR"

  mkdir -p "$BATS_TEST_TMPDIR/usr/lib"
  cp "$TEST_STATICS/binaries/libhello-x86-stripped.so" "$BATS_TEST_TMPDIR/usr/lib/"

  create_file_types "$BATS_TEST_TMPDIR"
  PKG_ARCH=i486

  run check

  refute_output
}

@test "Check logs no error when x86 32-bit library in /usr/lib for i686 package" {
  create_empty_package "$BATS_TEST_TMPDIR"

  mkdir -p "$BATS_TEST_TMPDIR/usr/lib"
  cp "$TEST_STATICS/binaries/libhello-x86-stripped.so" "$BATS_TEST_TMPDIR/usr/lib/"

  create_file_types "$BATS_TEST_TMPDIR"
  PKG_ARCH=i686

  run check

  refute_output
}

@test "Check logs no error when file name in /usr/lib64 mentions 32-bit ELF for i686 package" {
  create_empty_package "$BATS_TEST_TMPDIR"

  mkdir -p "$BATS_TEST_TMPDIR/usr/lib64"
  echo "notes" > "$BATS_TEST_TMPDIR/usr/lib64/ELF 32-bit notes.txt"

  create_file_types "$BATS_TEST_TMPDIR"
  PKG_ARCH=i686

  run check

  refute_output
}
