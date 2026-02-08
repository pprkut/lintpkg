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

@test "Check logs error when info page in /usr/share/info" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/info
  makeinfo $DOCS/lintpkg.texi -o $BASE/usr/share/info/
  gzip -9 $BASE/usr/share/info/lintpkg.info

  WORKING_DIR=$BASE

  run check

  assert_output "error incorrect-info-dir /usr/share/info"

  rm -rf "$BASE"
}

@test "Check logs error when info page in /usr/local/info" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/local/info
  makeinfo $DOCS/lintpkg.texi -o $BASE/usr/local/info/
  gzip -9 $BASE/usr/local/info/lintpkg.info

  WORKING_DIR=$BASE

  run check

  assert_output "error incorrect-info-dir /usr/local/info"

  rm -rf "$BASE"
}

@test "Check logs error when info page in /usr/local/share/info" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/local/share/info
  makeinfo $DOCS/lintpkg.texi -o $BASE/usr/local/share/info/
  gzip -9 $BASE/usr/local/share/info/lintpkg.info

  WORKING_DIR=$BASE

  run check

  assert_output "error incorrect-info-dir /usr/local/share/info"

  rm -rf "$BASE"
}

@test "Check logs warning when uncompressed info page in /usr/info" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/info
  makeinfo $DOCS/lintpkg.texi -o $BASE/usr/info/

  WORKING_DIR=$BASE

  run check

  assert_output "warning uncompressed-info-page $BASE/usr/info/lintpkg.info"

  rm -rf "$BASE"
}

@test "Check logs warning when uncompressed info page in /usr/share/info" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/info
  makeinfo $DOCS/lintpkg.texi -o $BASE/usr/share/info/

  WORKING_DIR=$BASE

  run check

  EXPECTED=""
  EXPECTED+="error incorrect-info-dir /usr/share/info"$'\n'
  EXPECTED+="warning uncompressed-info-page $BASE/usr/share/info/lintpkg.info"

  assert_output "$EXPECTED"

  rm -rf "$BASE"
}

@test "Check logs warning when uncompressed info page in /usr/local/info" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/local/info
  makeinfo $DOCS/lintpkg.texi -o $BASE/usr/local/info/

  WORKING_DIR=$BASE

  run check

  EXPECTED=""
  EXPECTED+="error incorrect-info-dir /usr/local/info"$'\n'
  EXPECTED+="warning uncompressed-info-page $BASE/usr/local/info/lintpkg.info"

  assert_output "$EXPECTED"

  rm -rf "$BASE"
}

@test "Check logs warning when uncompressed info page in /usr/local/share/info" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/local/share/info
  makeinfo $DOCS/lintpkg.texi -o $BASE/usr/local/share/info/

  WORKING_DIR=$BASE

  run check

  EXPECTED=""
  EXPECTED+="error incorrect-info-dir /usr/local/share/info"$'\n'
  EXPECTED+="warning uncompressed-info-page $BASE/usr/local/share/info/lintpkg.info"

  assert_output "$EXPECTED"

  rm -rf "$BASE"
}
