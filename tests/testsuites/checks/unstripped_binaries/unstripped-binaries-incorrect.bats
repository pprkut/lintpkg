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
  . "$LIVE_CHECKS/unstripped_binaries_check.sh"
}

@test "Check logs warning when unstripped x86 64-bit binary in /bin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/bin
  cp $TEST_STATICS/binaries/hello-x86_64-unstripped $BATS_TEST_TMPDIR/bin/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "warning unstripped-binary $BATS_TEST_TMPDIR/bin/hello-x86_64-unstripped"
}

@test "Check logs warning when unstripped x86 64-bit binary in /sbin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/sbin
  cp $TEST_STATICS/binaries/hello-x86_64-unstripped $BATS_TEST_TMPDIR/sbin/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "warning unstripped-binary $BATS_TEST_TMPDIR/sbin/hello-x86_64-unstripped"
}

@test "Check logs warning when unstripped x86 64-bit library in /lib64" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/lib64
  cp $TEST_STATICS/binaries/libhello-x86_64-unstripped.so $BATS_TEST_TMPDIR/lib64/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "warning unstripped-binary $BATS_TEST_TMPDIR/lib64/libhello-x86_64-unstripped.so"
}

@test "Check logs warning when unstripped x86 64-bit binary in /usr/bin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/bin
  cp $TEST_STATICS/binaries/hello-x86_64-unstripped $BATS_TEST_TMPDIR/usr/bin/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "warning unstripped-binary $BATS_TEST_TMPDIR/usr/bin/hello-x86_64-unstripped"
}

@test "Check logs warning when unstripped x86 64-bit binary in /usr/sbin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/sbin
  cp $TEST_STATICS/binaries/hello-x86_64-unstripped $BATS_TEST_TMPDIR/usr/sbin/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "warning unstripped-binary $BATS_TEST_TMPDIR/usr/sbin/hello-x86_64-unstripped"
}

@test "Check logs warning when unstripped x86 64-bit library in /usr/lib64" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/lib64
  cp $TEST_STATICS/binaries/libhello-x86_64-unstripped.so $BATS_TEST_TMPDIR/usr/lib64/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "warning unstripped-binary $BATS_TEST_TMPDIR/usr/lib64/libhello-x86_64-unstripped.so"
}

@test "Check logs warning when unstripped x86 32-bit binary in /bin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/bin
  cp $TEST_STATICS/binaries/hello-x86-unstripped $BATS_TEST_TMPDIR/bin/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "warning unstripped-binary $BATS_TEST_TMPDIR/bin/hello-x86-unstripped"
}

@test "Check logs warning when unstripped x86 32-bit binary in /sbin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/sbin
  cp $TEST_STATICS/binaries/hello-x86-unstripped $BATS_TEST_TMPDIR/sbin/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "warning unstripped-binary $BATS_TEST_TMPDIR/sbin/hello-x86-unstripped"
}

@test "Check logs warning when unstripped x86 32-bit library in /lib" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/lib
  cp $TEST_STATICS/binaries/libhello-x86-unstripped.so $BATS_TEST_TMPDIR/lib/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "warning unstripped-binary $BATS_TEST_TMPDIR/lib/libhello-x86-unstripped.so"
}

@test "Check logs warning when unstripped x86 32-bit binary in /usr/bin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/bin
  cp $TEST_STATICS/binaries/hello-x86-unstripped $BATS_TEST_TMPDIR/usr/bin/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "warning unstripped-binary $BATS_TEST_TMPDIR/usr/bin/hello-x86-unstripped"
}

@test "Check logs warning when unstripped x86 32-bit binary in /usr/sbin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/sbin
  cp $TEST_STATICS/binaries/hello-x86-unstripped $BATS_TEST_TMPDIR/usr/sbin/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "warning unstripped-binary $BATS_TEST_TMPDIR/usr/sbin/hello-x86-unstripped"
}

@test "Check logs warning when unstripped x86 32-bit library in /usr/lib" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/lib
  cp $TEST_STATICS/binaries/libhello-x86-unstripped.so $BATS_TEST_TMPDIR/usr/lib/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "warning unstripped-binary $BATS_TEST_TMPDIR/usr/lib/libhello-x86-unstripped.so"
}
