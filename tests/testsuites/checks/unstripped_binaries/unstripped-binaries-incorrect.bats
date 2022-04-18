#!/usr/bin/env bats

TESTSUITE="unstripped_binaries"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/unstripped_binaries_check.sh"
}

@test "[$TESTSUITE] Check logs warning when unstripped x86 64-bit binary in /bin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/bin
  cp $TEST_STATICS/binaries/hello-x86_64-unstripped $BASE/bin/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning unstripped-binary $BASE/bin/hello-x86_64-unstripped" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when unstripped x86 64-bit binary in /sbin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/sbin
  cp $TEST_STATICS/binaries/hello-x86_64-unstripped $BASE/sbin/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning unstripped-binary $BASE/sbin/hello-x86_64-unstripped" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when unstripped x86 64-bit library in /lib64" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/lib64
  cp $TEST_STATICS/binaries/libhello-x86_64-unstripped.so $BASE/lib64/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning unstripped-binary $BASE/lib64/libhello-x86_64-unstripped.so" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when unstripped x86 64-bit binary in /usr/bin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/bin
  cp $TEST_STATICS/binaries/hello-x86_64-unstripped $BASE/usr/bin/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning unstripped-binary $BASE/usr/bin/hello-x86_64-unstripped" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when unstripped x86 64-bit binary in /usr/sbin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/sbin
  cp $TEST_STATICS/binaries/hello-x86_64-unstripped $BASE/usr/sbin/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning unstripped-binary $BASE/usr/sbin/hello-x86_64-unstripped" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when unstripped x86 64-bit library in /usr/lib64" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/lib64
  cp $TEST_STATICS/binaries/libhello-x86_64-unstripped.so $BASE/usr/lib64/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning unstripped-binary $BASE/usr/lib64/libhello-x86_64-unstripped.so" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when unstripped x86 32-bit binary in /bin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/bin
  cp $TEST_STATICS/binaries/hello-x86-unstripped $BASE/bin/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning unstripped-binary $BASE/bin/hello-x86-unstripped" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when unstripped x86 32-bit binary in /sbin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/sbin
  cp $TEST_STATICS/binaries/hello-x86-unstripped $BASE/sbin/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning unstripped-binary $BASE/sbin/hello-x86-unstripped" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when unstripped x86 32-bit library in /lib" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/lib
  cp $TEST_STATICS/binaries/libhello-x86-unstripped.so $BASE/lib/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning unstripped-binary $BASE/lib/libhello-x86-unstripped.so" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when unstripped x86 32-bit binary in /usr/bin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/bin
  cp $TEST_STATICS/binaries/hello-x86-unstripped $BASE/usr/bin/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning unstripped-binary $BASE/usr/bin/hello-x86-unstripped" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when unstripped x86 32-bit binary in /usr/sbin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/sbin
  cp $TEST_STATICS/binaries/hello-x86-unstripped $BASE/usr/sbin/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning unstripped-binary $BASE/usr/sbin/hello-x86-unstripped" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when unstripped x86 32-bit library in /usr/lib" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/lib
  cp $TEST_STATICS/binaries/libhello-x86-unstripped.so $BASE/usr/lib/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning unstripped-binary $BASE/usr/lib/libhello-x86-unstripped.so" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}
