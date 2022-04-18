#!/usr/bin/env bats

TESTSUITE="unstripped_binaries"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/unstripped_binaries_check.sh"
}

@test "[$TESTSUITE] Check logs no warning when stripped x86 64-bit binary in /bin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/bin
  cp $TEST_STATICS/binaries/hello-x86_64-stripped $BASE/bin/

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no warning when stripped x86 64-bit binary in /sbin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/sbin
  cp $TEST_STATICS/binaries/hello-x86_64-stripped $BASE/sbin/

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no warning when stripped x86 64-bit library in /lib64" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/lib64
  cp $TEST_STATICS/binaries/libhello-x86_64-stripped.so $BASE/lib64/

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no warning when stripped x86 64-bit binary in /usr/bin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/bin
  cp $TEST_STATICS/binaries/hello-x86_64-stripped $BASE/usr/bin/

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no warning when stripped x86 64-bit binary in /usr/sbin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/sbin
  cp $TEST_STATICS/binaries/hello-x86_64-stripped $BASE/usr/sbin/

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no warning when stripped x86 64-bit library in /usr/lib64" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/lib64
  cp $TEST_STATICS/binaries/libhello-x86_64-stripped.so $BASE/usr/lib64/

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no warning when stripped x86 32-bit binary in /bin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/bin
  cp $TEST_STATICS/binaries/hello-x86-stripped $BASE/bin/

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no warning when stripped x86 32-bit binary in /sbin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/sbin
  cp $TEST_STATICS/binaries/hello-x86-stripped $BASE/sbin/

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no warning when stripped x86 32-bit library in /lib" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/lib
  cp $TEST_STATICS/binaries/libhello-x86-stripped.so $BASE/lib/

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no warning when stripped x86 32-bit binary in /usr/bin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/bin
  cp $TEST_STATICS/binaries/hello-x86-stripped $BASE/usr/bin/

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no warning when stripped x86 32-bit binary in /usr/sbin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/sbin
  cp $TEST_STATICS/binaries/hello-x86-stripped $BASE/usr/sbin/

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no warning when stripped x86 32-bit library in /usr/lib" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/lib
  cp $TEST_STATICS/binaries/libhello-x86-stripped.so $BASE/usr/lib/

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}
