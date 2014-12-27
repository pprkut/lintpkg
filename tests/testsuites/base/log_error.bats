#!/usr/bin/env bats

load ../../helpers/locations
load ../../helpers/makepkg

@test "logging error without info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_error_check "$PKG"

  [ "${lines[0]}" == "empty-1.0-noarch-1: E: simple-error /path/to/file" ]
  [ "${lines[1]}" == "1 packages checked; 1 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "logging error with info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_error_check -i "$PKG"

  [ "${lines[0]}" == "empty-1.0-noarch-1: E: simple-error /path/to/file" ]
  [ "${lines[1]}" == "A error for a simple path" ]
  [ "${lines[2]}" == "1 packages checked; 1 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "logging error for path with whitespaces without info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_whitespace_error_check "$PKG"

  [ "${lines[0]}" == "empty-1.0-noarch-1: E: whitespace-error /path/t o/a file" ]
  [ "${lines[1]}" == "1 packages checked; 1 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "logging error for path with whitespaces with info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_whitespace_error_check -i "$PKG"

  [ "${lines[0]}" == "empty-1.0-noarch-1: E: whitespace-error /path/t o/a file" ]
  [ "${lines[1]}" == "A error for a path containing whitespaces" ]
  [ "${lines[2]}" == "1 packages checked; 1 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "logging error ignored with -x does not print message" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_error_check -x simple-error "$PKG"

  [ "${lines[0]}" == "1 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "logging error ignored with --exclude does not print message" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_error_check --exclude simple-error "$PKG"

  [ "${lines[0]}" == "1 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "logging error ignored with -x does not print info message" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_error_check -x simple-error -i "$PKG"

  [ "${lines[0]}" == "1 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "logging error ignored with --exclude does not print info message" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_error_check --exclude simple-error -i "$PKG"

  [ "${lines[0]}" == "1 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "logging error removes working directory prefix from path" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_workingdir_error_check "$PKG"

  [ "${lines[0]}" == "empty-1.0-noarch-1: E: working-dir-error /usr/bin/foo" ]
  [ "${lines[1]}" == "1 packages checked; 1 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

