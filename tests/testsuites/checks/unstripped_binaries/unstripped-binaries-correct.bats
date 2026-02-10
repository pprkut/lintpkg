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

@test "Check logs no warning when stripped x86 64-bit binary in /bin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/bin
  cp $TEST_STATICS/binaries/hello-x86_64-stripped $BATS_TEST_TMPDIR/bin/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}

@test "Check logs no warning when stripped x86 64-bit binary in /sbin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/sbin
  cp $TEST_STATICS/binaries/hello-x86_64-stripped $BATS_TEST_TMPDIR/sbin/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}

@test "Check logs no warning when stripped x86 64-bit library in /lib64" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/lib64
  cp $TEST_STATICS/binaries/libhello-x86_64-stripped.so $BATS_TEST_TMPDIR/lib64/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}

@test "Check logs no warning when stripped x86 64-bit binary in /usr/bin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/bin
  cp $TEST_STATICS/binaries/hello-x86_64-stripped $BATS_TEST_TMPDIR/usr/bin/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}

@test "Check logs no warning when stripped x86 64-bit binary in /usr/sbin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/sbin
  cp $TEST_STATICS/binaries/hello-x86_64-stripped $BATS_TEST_TMPDIR/usr/sbin/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}

@test "Check logs no warning when stripped x86 64-bit library in /usr/lib64" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/lib64
  cp $TEST_STATICS/binaries/libhello-x86_64-stripped.so $BATS_TEST_TMPDIR/usr/lib64/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}

@test "Check logs no warning when stripped x86 32-bit binary in /bin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/bin
  cp $TEST_STATICS/binaries/hello-x86-stripped $BATS_TEST_TMPDIR/bin/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}

@test "Check logs no warning when stripped x86 32-bit binary in /sbin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/sbin
  cp $TEST_STATICS/binaries/hello-x86-stripped $BATS_TEST_TMPDIR/sbin/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}

@test "Check logs no warning when stripped x86 32-bit library in /lib" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/lib
  cp $TEST_STATICS/binaries/libhello-x86-stripped.so $BATS_TEST_TMPDIR/lib/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}

@test "Check logs no warning when stripped x86 32-bit binary in /usr/bin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/bin
  cp $TEST_STATICS/binaries/hello-x86-stripped $BATS_TEST_TMPDIR/usr/bin/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}

@test "Check logs no warning when stripped x86 32-bit binary in /usr/sbin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/sbin
  cp $TEST_STATICS/binaries/hello-x86-stripped $BATS_TEST_TMPDIR/usr/sbin/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}

@test "Check logs no warning when stripped x86 32-bit library in /usr/lib" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/lib
  cp $TEST_STATICS/binaries/libhello-x86-stripped.so $BATS_TEST_TMPDIR/usr/lib/

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}
