#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/symlink_check.sh"
}

@test "Check logs warning when a single symlink is present" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  ln -s foo $BASE/usr/bin/foo2

  WORKING_DIR=$BASE

  run check

  assert_output "warning package-contains-symlink $BASE/usr/bin/foo2"

  rm -rf "$BASE"
}

@test "Check logs warning when multiple symlinks are present" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  ln -s foo $BASE/usr/bin/foo2
  ln -s foo $BASE/usr/bin/foo3

  WORKING_DIR=$BASE

  run check

  EXPECTED=""
  EXPECTED+="warning package-contains-symlink $BASE/usr/bin/foo2"$'\n'
  EXPECTED+="warning package-contains-symlink $BASE/usr/bin/foo3"

  assert_output "$EXPECTED"

  rm -rf "$BASE"
}

@test "Check logs warning when a single symlink with spaces in its name is present" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  ln -s foo "$BASE/usr/bin/foo 2"

  WORKING_DIR=$BASE

  run check

  assert_output "warning package-contains-symlink $BASE/usr/bin/foo 2"

  rm -rf "$BASE"
}

@test "Check logs warning when multiple symlinks with spaces in their name are present" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  ln -s foo "$BASE/usr/bin/foo 2"
  ln -s foo "$BASE/usr/bin/foo 3"

  WORKING_DIR=$BASE

  run check

  EXPECTED=""
  EXPECTED+="warning package-contains-symlink $BASE/usr/bin/foo 2"$'\n'
  EXPECTED+="warning package-contains-symlink $BASE/usr/bin/foo 3"

  assert_output "$EXPECTED"

  rm -rf "$BASE"
}
