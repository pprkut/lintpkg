#!/usr/bin/env bats

TESTSUITE="ownership"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/ownership_check.sh"
}

@test "[$TESTSUITE] Check logs no error when correct owner and group for /bin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  rm -rf $BASE/usr

  mkdir -p $BASE/bin

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g")

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no error when correct owner and group for file in /bin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/bin
  touch $BASE/bin/foo

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g")

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no error when correct owner and group for /lib" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  rm -rf $BASE/lib

  mkdir -p $BASE/lib

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g")

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no error when correct owner and group for file in /lib" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/lib
  touch $BASE/lib/baz

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g")

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no error when correct owner and group for /lib64" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  rm -rf $BASE/lib64

  mkdir -p $BASE/lib64

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g")

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no error when correct owner and group for file in /lib64" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/lib64
  touch $BASE/lib64/baz

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g")

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no error when correct owner and group for /sbin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  rm -rf $BASE/usr

  mkdir -p $BASE/sbin

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g")

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no error when correct owner and group for file in /sbin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/sbin
  touch $BASE/sbin/baz

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g")

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no error when correct owner and group for /usr" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  rm -rf $BASE/usr/bin

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g")

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no error when correct owner and group for file in /usr" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g")

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no error when correct owner and group for /" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  rm -rf $BASE/usr

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g")

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no error when owner is whitelisted (daemon) for file in /usr/bin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g" | sed "/usr\/bin\/foo/s|root/root|daemon/daemon|g")

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no error when owner is whitelisted (uucp) for file in /usr/bin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g" | sed "/usr\/bin\/foo/s|root/root|uucp/uucp|g")

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no error when owner is whitelisted (daemon) for file in /usr/sbin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  mv $BASE/usr/bin $BASE/usr/sbin

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g" | sed "/usr\/sbin\/foo/s|root/root|daemon/daemon|g")

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs no error when owner is whitelisted (uucp) for file in /usr/sbin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  mv $BASE/usr/bin $BASE/usr/sbin

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g" | sed "/usr\/sbin\/foo/s|root/root|uucp/uucp|g")

  run check

  [ -z "${lines[0]}" ]

  rm -rf "$BASE"
}
