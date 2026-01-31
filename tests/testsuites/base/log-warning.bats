#!/usr/bin/env bats

load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Logging warning without info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_warning_check "$PKG"

  [ "${lines[0]}" == "empty-1.0-noarch-1: W: simple-warning /path/to/file" ]
  [ "${lines[1]}" == "1 packages checked; 0 errors and 1 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Logging warning with info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_warning_check -i "$PKG"

  [ "${lines[0]}" == "empty-1.0-noarch-1: W: simple-warning /path/to/file" ]
  [ "${lines[1]}" == "A warning for a simple path" ]
  [ "${lines[2]}" == "1 packages checked; 0 errors and 1 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Logging warning for path with whitespaces without info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_whitespace_warning_check "$PKG"

  [ "${lines[0]}" == "empty-1.0-noarch-1: W: whitespace-warning /path/t o/a file" ]
  [ "${lines[1]}" == "1 packages checked; 0 errors and 1 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Logging warning for path with whitespaces with info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_whitespace_warning_check -i "$PKG"

  [ "${lines[0]}" == "empty-1.0-noarch-1: W: whitespace-warning /path/t o/a file" ]
  [ "${lines[1]}" == "A warning for a path containing whitespaces" ]
  [ "${lines[2]}" == "1 packages checked; 0 errors and 1 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Logging warning ignored with -x does not print message" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_warning_check -x simple-warning "$PKG"

  [ "${lines[0]}" == "1 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Logging warning ignored with --exclude does not print message" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_warning_check --exclude simple-warning "$PKG"

  [ "${lines[0]}" == "1 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Logging warning ignored with -x does not print info message" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_warning_check -x simple-warning -i "$PKG"

  [ "${lines[0]}" == "1 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Logging warning ignored with --exclude does not print info message" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_warning_check --exclude simple-warning -i "$PKG"

  [ "${lines[0]}" == "1 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Logging warning removes working directory prefix from path" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_workingdir_warning_check "$PKG"

  [ "${lines[0]}" == "empty-1.0-noarch-1: W: working-dir-warning /usr/bin/foo" ]
  [ "${lines[1]}" == "1 packages checked; 0 errors and 1 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}
