#!/usr/bin/env bats

TESTSUITE="usr_share"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/usr_share_check.sh"
}

@test "[$TESTSUITE] Check logs error when binary in /usr/share" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/test
  cp $TEST_STATICS/binaries/hello-x86_64-stripped $BASE/usr/share/test/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error binary-in-usr-share $BASE/usr/share/test/hello-x86_64-stripped" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when shared library in /usr/share" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/test
  cp $TEST_STATICS/binaries/libhello-x86_64-stripped.so $BASE/usr/share/test/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error binary-in-usr-share $BASE/usr/share/test/libhello-x86_64-stripped.so" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when static library in /usr/share" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/test
  cp $TEST_STATICS/binaries/libhello-x86_64-stripped.a $BASE/usr/share/test/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error binary-in-usr-share $BASE/usr/share/test/libhello-x86_64-stripped.a" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}
