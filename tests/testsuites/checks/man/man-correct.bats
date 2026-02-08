#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/man_check.sh"
}

@test "Check logs no error when correct directory and compressed" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/man/man1
  cp $DOCS/lintpkg.1 $BASE/usr/man/man1/
  gzip -9 $BASE/usr/man/man1/lintpkg.1

  WORKING_DIR=$BASE

  run check

  refute_output

  rm -rf "$BASE"
}
