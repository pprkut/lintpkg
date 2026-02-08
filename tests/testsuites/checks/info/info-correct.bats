#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/info_check.sh"
}

@test "Check logs no error when correct directory and compressed" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/info
  makeinfo $DOCS/lintpkg.texi -o $BASE/usr/info/
  gzip -9 $BASE/usr/info/lintpkg.info

  WORKING_DIR=$BASE

  run check

  refute_output

  rm -rf "$BASE"
}

@test "Check logs no warning for png in correct directory" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/info
  touch $BASE/usr/info/lintpkg.png

  WORKING_DIR=$BASE

  run check

  refute_output

  rm -rf "$BASE"
}

