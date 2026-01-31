#!/usr/bin/env bats

load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/shared_libraries_check.sh"
}

@test "Check logs error when libtool archive without header" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/lib/app/private/

  sed '1,7d' $TEST_STATICS/shared-libraries/foo-ltmain.la > $BASE/usr/lib/app/private/foo.la

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error invalid-libtool-archive $BASE/usr/lib/app/private/foo.la" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}
