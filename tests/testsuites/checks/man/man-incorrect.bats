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

@test "Check logs error when man page in /usr/share/man" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/man/man1
  cp $DOCS/lintpkg.1 $BASE/usr/share/man/man1/
  gzip -9 $BASE/usr/share/man/man1/lintpkg.1

  WORKING_DIR=$BASE

  run check

  assert_output "error incorrect-man-dir /usr/share/man"

  rm -rf "$BASE"
}

@test "Check logs error when man page in /usr/local/man" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/local/man/man1
  cp $DOCS/lintpkg.1 $BASE/usr/local/man/man1/
  gzip -9 $BASE/usr/local/man/man1/lintpkg.1

  WORKING_DIR=$BASE

  run check

  assert_output "error incorrect-man-dir /usr/local/man"

  rm -rf "$BASE"
}

@test "Check logs error when man page in /usr/local/share/man" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/local/share/man/man1
  cp $DOCS/lintpkg.1 $BASE/usr/local/share/man/man1
  gzip -9 $BASE/usr/local/share/man/man1/lintpkg.1

  WORKING_DIR=$BASE

  run check

  assert_output "error incorrect-man-dir /usr/local/share/man"

  rm -rf "$BASE"
}

@test "Check logs warning when uncompressed man page in /usr/man" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/man/man1
  cp $DOCS/lintpkg.1 $BASE/usr/man/man1/

  WORKING_DIR=$BASE

  run check

  assert_output "warning uncompressed-man-page $BASE/usr/man/man1/lintpkg.1"

  rm -rf "$BASE"
}

@test "Check logs warning when uncompressed man page in /usr/share/man" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/share/man/man1
  cp $DOCS/lintpkg.1 $BASE/usr/share/man/man1/

  WORKING_DIR=$BASE

  run check

  EXPECTED=""
  EXPECTED+="error incorrect-man-dir /usr/share/man"$'\n'
  EXPECTED+="warning uncompressed-man-page $BASE/usr/share/man/man1/lintpkg.1"

  assert_output "$EXPECTED"

  rm -rf "$BASE"
}

@test "Check logs warning when uncompressed man page in /usr/local/man" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/local/man/man1
  cp $DOCS/lintpkg.1 $BASE/usr/local/man/man1/

  WORKING_DIR=$BASE

  run check

  EXPECTED=""
  EXPECTED+="error incorrect-man-dir /usr/local/man"$'\n'
  EXPECTED+="warning uncompressed-man-page $BASE/usr/local/man/man1/lintpkg.1"

  assert_output "$EXPECTED"

  rm -rf "$BASE"
}

@test "Check logs warning when uncompressed man page in /usr/local/share/man" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/local/share/man/man1
  cp $DOCS/lintpkg.1 $BASE/usr/local/share/man/man1/

  WORKING_DIR=$BASE

  run check

  EXPECTED=""
  EXPECTED+="error incorrect-man-dir /usr/local/share/man"$'\n'
  EXPECTED+="warning uncompressed-man-page $BASE/usr/local/share/man/man1/lintpkg.1"

  assert_output "$EXPECTED"

  rm -rf "$BASE"
}
