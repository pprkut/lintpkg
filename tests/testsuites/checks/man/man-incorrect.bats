#!/usr/bin/env bats

TESTSUITE="man"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/man_check.sh"
}

@test "[$TESTSUITE] Check logs error when man page in /usr/share/man" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/man/man1
  cp $DOCS/lintpkg.1 $BASE/usr/share/man/man1/
  gzip -9 $BASE/usr/share/man/man1/lintpkg.1

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error incorrect-man-dir /usr/share/man" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when man page in /usr/local/man" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/local/man/man1
  cp $DOCS/lintpkg.1 $BASE/usr/local/man/man1/
  gzip -9 $BASE/usr/local/man/man1/lintpkg.1

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error incorrect-man-dir /usr/local/man" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when man page in /usr/local/share/man" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/local/share/man/man1
  cp $DOCS/lintpkg.1 $BASE/usr/local/share/man/man1
  gzip -9 $BASE/usr/local/share/man/man1/lintpkg.1

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error incorrect-man-dir /usr/local/share/man" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when uncompressed man page in /usr/man" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/man/man1
  cp $DOCS/lintpkg.1 $BASE/usr/man/man1/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "warning uncompressed-man-page $BASE/usr/man/man1/lintpkg.1" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when uncompressed man page in /usr/share/man" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/man/man1
  cp $DOCS/lintpkg.1 $BASE/usr/share/man/man1/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error incorrect-man-dir /usr/share/man" ]
  [ "${lines[1]}" == "warning uncompressed-man-page $BASE/usr/share/man/man1/lintpkg.1" ]
  [ -z "${lines[2]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when uncompressed man page in /usr/local/man" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/local/man/man1
  cp $DOCS/lintpkg.1 $BASE/usr/local/man/man1/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error incorrect-man-dir /usr/local/man" ]
  [ "${lines[1]}" == "warning uncompressed-man-page $BASE/usr/local/man/man1/lintpkg.1" ]
  [ -z "${lines[2]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs warning when uncompressed man page in /usr/local/share/man" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/local/share/man/man1
  cp $DOCS/lintpkg.1 $BASE/usr/local/share/man/man1/

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error incorrect-man-dir /usr/local/share/man" ]
  [ "${lines[1]}" == "warning uncompressed-man-page $BASE/usr/local/share/man/man1/lintpkg.1" ]
  [ -z "${lines[2]}" ]

  rm -rf "$BASE"
}
