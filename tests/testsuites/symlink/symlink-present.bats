#!/usr/bin/env bats

TESTSUITE="symlink"

load ../../helpers/locations
load ../../helpers/makepkg
load ../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/symlink_check.sh"
}

@test "[$TESTSUITE] Check logs warning when a single symlink is present" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  ln -s foo $BASE/usr/bin/foo2

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning package-contains-symlink $BASE/usr/bin/foo2" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when multiple symlinks are present" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  ln -s foo $BASE/usr/bin/foo2
  ln -s foo $BASE/usr/bin/foo3

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning package-contains-symlink $BASE/usr/bin/foo2" ]
  [ "${lines[1]}" == "warning package-contains-symlink $BASE/usr/bin/foo3" ]
  [ -z "${lines[2]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when a single symlink with spaces in its name is present" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  ln -s foo "$BASE/usr/bin/foo 2"

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning package-contains-symlink $BASE/usr/bin/foo 2" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when multiple symlinks with spaces in their name are present" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  ln -s foo "$BASE/usr/bin/foo 2"
  ln -s foo "$BASE/usr/bin/foo 3"

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning package-contains-symlink $BASE/usr/bin/foo 2" ]
  [ "${lines[1]}" == "warning package-contains-symlink $BASE/usr/bin/foo 3" ]
  [ -z "${lines[2]}" ]

  rm -rf "$BASE"
}
