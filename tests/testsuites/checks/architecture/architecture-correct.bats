#!/usr/bin/env bats

TESTSUITE="architecture"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/architecture_check.sh"
}

@test "[$TESTSUITE] Check logs no error when x86 64-bit library in /usr/lib64" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/lib64
  cp $TEST_STATICS/binaries/libhello-x86_64-stripped.so $BASE/usr/lib64/

  WORKING_DIR=$BASE
  PKG_ARCH=x86_64

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no error when x86 32-bit library in /usr/lib for i486 package" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/lib
  cp $TEST_STATICS/binaries/libhello-x86-stripped.so $BASE/usr/lib/

  WORKING_DIR=$BASE
  PKG_ARCH=i486

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no error when x86 32-bit library in /usr/lib for i686 package" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/lib
  cp $TEST_STATICS/binaries/libhello-x86-stripped.so $BASE/usr/lib/

  WORKING_DIR=$BASE
  PKG_ARCH=i686

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}
