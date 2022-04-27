#!/usr/bin/env bats

TESTSUITE="ownership"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/ownership_check.sh"
}

@test "[$TESTSUITE] Check logs error when incorrect owner for /bin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  rm -rf $BASE/usr

  mkdir -p $BASE/bin

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g" | sed "/bin/s|root/root|slacker/root|")

  run check

  [ "${lines[0]}" == "error strange-owner-or-group bin/ slacker/root" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when incorrect owner for file in /bin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/bin
  touch $BASE/bin/baz

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g" | sed "/bin\/baz/s|root/root|slacker/root|")

  run check

  [ "${lines[0]}" == "error strange-owner-or-group bin/baz slacker/root" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when incorrect owner for /lib" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  rm -rf $BASE/lib

  mkdir -p $BASE/lib

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g" | sed "/lib/s|root/root|slacker/root|")

  run check

  [ "${lines[0]}" == "error strange-owner-or-group lib/ slacker/root" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when incorrect owner for file in /lib" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/lib
  touch $BASE/lib/baz

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g" | sed "/lib\/baz/s|root/root|slacker/root|")

  run check

  [ "${lines[0]}" == "error strange-owner-or-group lib/baz slacker/root" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when incorrect owner for /lib64" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  rm -rf $BASE/lib64

  mkdir -p $BASE/lib64

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g" | sed "/lib64/s|root/root|slacker/root|")

  run check

  [ "${lines[0]}" == "error strange-owner-or-group lib64/ slacker/root" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when incorrect owner for file in /lib64" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/lib64
  touch $BASE/lib64/baz

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g" | sed "/lib64\/baz/s|root/root|slacker/root|")

  run check

  [ "${lines[0]}" == "error strange-owner-or-group lib64/baz slacker/root" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when incorrect owner for /sbin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  rm -rf $BASE/usr

  mkdir -p $BASE/sbin

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g" | sed "/sbin/s|root/root|slacker/root|")

  run check

  [ "${lines[0]}" == "error strange-owner-or-group sbin/ slacker/root" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when incorrect owner for file in /sbin" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  mkdir -p $BASE/sbin
  touch $BASE/sbin/baz

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g" | sed "/sbin\/baz/s|root/root|slacker/root|")

  run check

  [ "${lines[0]}" == "error strange-owner-or-group sbin/baz slacker/root" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when incorrect owner for /usr" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  rm -rf $BASE/usr/bin

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g" | sed "/usr/s|root/root|slacker/root|")

  run check

  [ "${lines[0]}" == "error strange-owner-or-group usr/ slacker/root" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when incorrect owner for file in /usr" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g" | sed "/usr\/bin\/foo/s|root/root|slacker/root|")

  run check

  [ "${lines[0]}" == "error strange-owner-or-group usr/bin/foo slacker/root" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}

@test "[$TESTSUITE] Check logs error when incorrect owner for /" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  rm -rf $BASE/usr

  WORKING_DIR=$BASE
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BASE | sed "s|$USER/$(id -gn)|root/root|g" | sed "/\.\//s|root/root|slacker/root|")

  run check

  [ "${lines[0]}" == "error strange-owner-or-group ./ slacker/root" ]
  [ -z "${lines[1]}" ]

  rm -rf "$BASE"
}
