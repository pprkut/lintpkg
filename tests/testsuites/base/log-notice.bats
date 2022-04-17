#!/usr/bin/env bats

TESTSUITE="base"

load ../../helpers/locations
load ../../helpers/makepkg

@test "[$TESTSUITE] Logging notice without info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_notice_check "$PKG"

  [ "${lines[0]}" == "empty-1.0-noarch-1: I: simple-notice /path/to/file" ]
  [ "${lines[1]}" == "1 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "[$TESTSUITE] Logging notice with info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_notice_check -i "$PKG"

  [ "${lines[0]}" == "empty-1.0-noarch-1: I: simple-notice /path/to/file" ]
  [ "${lines[1]}" == "A notice for a simple path" ]
  [ "${lines[2]}" == "1 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "[$TESTSUITE] Logging notice for path with whitespaces without info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_whitespace_notice_check "$PKG"

  [ "${lines[0]}" == "empty-1.0-noarch-1: I: whitespace-notice /path/t o/a file" ]
  [ "${lines[1]}" == "1 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "[$TESTSUITE] Logging notice for path with whitespaces with info" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_whitespace_notice_check -i "$PKG"

  [ "${lines[0]}" == "empty-1.0-noarch-1: I: whitespace-notice /path/t o/a file" ]
  [ "${lines[1]}" == "A notice for a path containing whitespaces" ]
  [ "${lines[2]}" == "1 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "[$TESTSUITE] Logging notice ignored with -x does not print message" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_notice_check -x simple-notice "$PKG"

  [ "${lines[0]}" == "1 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "[$TESTSUITE] Logging notice ignored with --exclude does not print message" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_notice_check --exclude simple-notice "$PKG"

  [ "${lines[0]}" == "1 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "[$TESTSUITE] Logging notice ignored with -x does not print info message" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_notice_check -x simple-notice -i "$PKG"

  [ "${lines[0]}" == "1 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "[$TESTSUITE] Logging notice ignored with --exclude does not print info message" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_notice_check --exclude simple-notice -i "$PKG"

  [ "${lines[0]}" == "1 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "[$TESTSUITE] Logging notice removes working directory prefix from path" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/logging" -c log_workingdir_notice_check "$PKG"

  [ "${lines[0]}" == "empty-1.0-noarch-1: I: working-dir-notice /usr/bin/foo" ]
  [ "${lines[1]}" == "1 packages checked; 0 errors and 0 warnings." ]

  rm -f "$PKG"
  rm -rf "$BASE"
}
