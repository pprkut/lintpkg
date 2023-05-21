#!/usr/bin/env bats

TESTSUITE="info"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/info_check.sh"
}

@test "[$TESTSUITE] Check logs error when info page in /usr/share/info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/info
  makeinfo $DOCS/lintpkg.texi -o $BASE/usr/share/info/
  gzip -9 $BASE/usr/share/info/lintpkg.info

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error incorrect-info-dir /usr/share/info" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when info page in /usr/local/info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/local/info
  makeinfo $DOCS/lintpkg.texi -o $BASE/usr/local/info/
  gzip -9 $BASE/usr/local/info/lintpkg.info

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error incorrect-info-dir /usr/local/info" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when info page in /usr/local/share/info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/local/share/info
  makeinfo $DOCS/lintpkg.texi -o $BASE/usr/local/share/info/
  gzip -9 $BASE/usr/local/share/info/lintpkg.info

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error incorrect-info-dir /usr/local/share/info" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when uncompressed info page in /usr/info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/info
  makeinfo $DOCS/lintpkg.texi -o $BASE/usr/info/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning uncompressed-info-page $BASE/usr/info/lintpkg.info" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when uncompressed info page in /usr/share/info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/info
  makeinfo $DOCS/lintpkg.texi -o $BASE/usr/share/info/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error incorrect-info-dir /usr/share/info" ]
  [ "${lines[1]}" == "warning uncompressed-info-page $BASE/usr/share/info/lintpkg.info" ]
  [ -z "${lines[2]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when uncompressed info page in /usr/local/info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/local/info
  makeinfo $DOCS/lintpkg.texi -o $BASE/usr/local/info/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error incorrect-info-dir /usr/local/info" ]
  [ "${lines[1]}" == "warning uncompressed-info-page $BASE/usr/local/info/lintpkg.info" ]
  [ -z "${lines[2]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when uncompressed info page in /usr/local/share/info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/local/share/info
  makeinfo $DOCS/lintpkg.texi -o $BASE/usr/local/share/info/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error incorrect-info-dir /usr/local/share/info" ]
  [ "${lines[1]}" == "warning uncompressed-info-page $BASE/usr/local/share/info/lintpkg.info" ]
  [ -z "${lines[2]}" ]

  rm -rf "$BASE"
}
