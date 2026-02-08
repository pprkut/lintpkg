#!/usr/bin/env bats

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
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/lib
  cp $TEST_STATICS/binaries/libhello-x86_64-stripped.so $BASE/usr/lib/

  WORKING_DIR=$BASE
  PKG_ARCH=x86_64

  run check

  assert_output "error binary-in-wrong-architecture-specific-path $BASE/usr/lib/libhello-x86_64-stripped.so"

  rm -rf "$BASE"
}

@test "Check logs error when x86 32-bit library in /usr/lib64 for i486 package" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/lib64
  cp $TEST_STATICS/binaries/libhello-x86-stripped.so $BASE/usr/lib64/

  WORKING_DIR=$BASE
  PKG_ARCH=i486

  run check

  assert_output "error binary-in-wrong-architecture-specific-path $BASE/usr/lib64/libhello-x86-stripped.so"

  rm -rf "$BASE"
}

@test "Check logs error when x86 32-bit library in /usr/lib64 for i686 package" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/lib64
  cp $TEST_STATICS/binaries/libhello-x86-stripped.so $BASE/usr/lib64/

  WORKING_DIR=$BASE
  PKG_ARCH=i686

  run check

  assert_output "error binary-in-wrong-architecture-specific-path $BASE/usr/lib64/libhello-x86-stripped.so"

  rm -rf "$BASE"
}
