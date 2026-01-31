#!/usr/bin/env bats

load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/permissions_check.sh"
}

@test "Check logs warning when incorrect permissions for /etc" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  mkdir -p $BASE/etc
  chmod 750 $BASE/etc

  run check

  [ "${lines[0]}" == "warning strange-permission $BASE/etc 750" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "Check logs warning when incorrect permissions for /usr" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  chmod 750 $BASE/usr

  run check

  [ "${lines[0]}" == "warning strange-permission $BASE/usr 750" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "Check logs warning when incorrect permissions for directory under /usr" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  chmod 750 $BASE/usr/bin

  run check

  [ "${lines[0]}" == "warning strange-permission $BASE/usr/bin 750" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

