#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2022  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/architecture_check.sh"
}

@test "Check logs error when x86 64-bit library in /usr/lib" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/lib
  cp $TEST_STATICS/binaries/libhello-x86_64-stripped.so $BATS_TEST_TMPDIR/usr/lib/

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_ARCH=x86_64

  run check

  assert_output "error binary-in-wrong-architecture-specific-path $BATS_TEST_TMPDIR/usr/lib/libhello-x86_64-stripped.so"
}

@test "Check logs error when x86 32-bit library in /usr/lib64 for i486 package" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/lib64
  cp $TEST_STATICS/binaries/libhello-x86-stripped.so $BATS_TEST_TMPDIR/usr/lib64/

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_ARCH=i486

  run check

  assert_output "error binary-in-wrong-architecture-specific-path $BATS_TEST_TMPDIR/usr/lib64/libhello-x86-stripped.so"
}

@test "Check logs error when x86 32-bit library in /usr/lib64 for i686 package" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/lib64
  cp $TEST_STATICS/binaries/libhello-x86-stripped.so $BATS_TEST_TMPDIR/usr/lib64/

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_ARCH=i686

  run check

  assert_output "error binary-in-wrong-architecture-specific-path $BATS_TEST_TMPDIR/usr/lib64/libhello-x86-stripped.so"
}
