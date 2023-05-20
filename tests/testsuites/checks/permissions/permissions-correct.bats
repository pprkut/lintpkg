#!/usr/bin/env bats

TESTSUITE="permissions"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/permissions_check.sh"
}

@test "[$TESTSUITE] Check logs no warning when correct permissions for /etc" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/etc
  chmod 755 $BASE/etc

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no warning when correct permissions for /usr" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  chmod 755 $BASE/usr

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no warning when correct permissions for directory under /usr" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  chmod 755 $BASE/usr/bin

  WORKING_DIR=$BASE

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

