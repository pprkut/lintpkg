#!/usr/bin/env bats

load ../../helpers/locations
load ../../helpers/makepkg
load ../../helpers/mock_loggers

setup() {
  . "$LIVE_CHECKS/disallowed_dirs_check.sh"
}

@test "disallowed_dirs_check logs error when package contains files under /home" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/home/user
  touch $BASE/home/user/foo

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error dir-or-file-in-home $BASE//home/user" ]
  [ "${lines[1]}" == "error dir-or-file-in-home $BASE//home/user/foo" ]
  [ -z "${lines[2]}" ]

  rm -rf "$BASE"
}

@test "disallowed_dirs_check logs error when package contains files under /mnt" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/mnt/hd
  touch $BASE/mnt/hd/foo

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error dir-or-file-in-mnt $BASE//mnt/hd" ]
  [ "${lines[1]}" == "error dir-or-file-in-mnt $BASE//mnt/hd/foo" ]
  [ -z "${lines[2]}" ]

  rm -rf "$BASE"
}

@test "disallowed_dirs_check logs error when package contains files under /tmp" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/tmp/foo
  touch $BASE/tmp/foo/bar

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error dir-or-file-in-tmp $BASE//tmp/foo" ]
  [ "${lines[1]}" == "error dir-or-file-in-tmp $BASE//tmp/foo/bar" ]
  [ -z "${lines[2]}" ]

  rm -rf "$BASE"
}

@test "disallowed_dirs_check logs error when package contains files under /usr/local" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/local/bin
  touch $BASE/usr/local/bin/foo

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error dir-or-file-in-usr-local $BASE//usr/local/bin" ]
  [ "${lines[1]}" == "error dir-or-file-in-usr-local $BASE//usr/local/bin/foo" ]
  [ -z "${lines[2]}" ]

  rm -rf "$BASE"
}

@test "disallowed_dirs_check logs error when package contains files under /usr/tmp" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/usr/tmp/foo
  touch $BASE/usr/tmp/foo/bar

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error dir-or-file-in-usr-tmp $BASE//usr/tmp/foo" ]
  [ "${lines[1]}" == "error dir-or-file-in-usr-tmp $BASE//usr/tmp/foo/bar" ]
  [ -z "${lines[2]}" ]

  rm -rf "$BASE"
}

@test "disallowed_dirs_check logs error when package contains files under /var/local" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/var/local/bar
  touch $BASE/var/local/bar/foo

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error dir-or-file-in-var-local $BASE//var/local/bar" ]
  [ "${lines[1]}" == "error dir-or-file-in-var-local $BASE//var/local/bar/foo" ]
  [ -z "${lines[2]}" ]

  rm -rf "$BASE"
}

@test "disallowed_dirs_check logs error when package contains files under /var/lock" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/var/lock/bar
  touch $BASE/var/lock/bar/foo

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error dir-or-file-in-var-lock $BASE//var/lock/bar" ]
  [ "${lines[1]}" == "error dir-or-file-in-var-lock $BASE//var/lock/bar/foo" ]
  [ -z "${lines[2]}" ]

  rm -rf "$BASE"
}

@test "disallowed_dirs_check logs error when package contains files under /var/run" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/var/run/bar
  touch $BASE/var/run/bar/foo

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error dir-or-file-in-var-run $BASE//var/run/bar" ]
  [ "${lines[1]}" == "error dir-or-file-in-var-run $BASE//var/run/bar/foo" ]
  [ -z "${lines[2]}" ]

  rm -rf "$BASE"
}

@test "disallowed_dirs_check logs error when package contains files under /var/tmp" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/var/tmp/bar
  touch $BASE/var/tmp/bar/foo

  WORKING_DIR=$BASE

  run check

  [ "${lines[0]}" == "error dir-or-file-in-var-tmp $BASE//var/tmp/bar" ]
  [ "${lines[1]}" == "error dir-or-file-in-var-tmp $BASE//var/tmp/bar/foo" ]
  [ -z "${lines[2]}" ]

  rm -rf "$BASE"
}
