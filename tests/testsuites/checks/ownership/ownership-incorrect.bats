#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/ownership_check.sh"
}

@test "Check logs error when incorrect owner for /bin" {
  create_empty_package $BATS_TEST_TMPDIR
  rm -rf $BATS_TEST_TMPDIR/usr

  mkdir -p $BATS_TEST_TMPDIR/bin

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BATS_TEST_TMPDIR | sed "s|$USER/$(id -gn)|root/root|g" | sed "/bin/s|root/root|slacker/root|")

  run check

  assert_output "error strange-owner-or-group bin/ slacker/root"
}

@test "Check logs error when incorrect owner for file in /bin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/bin
  touch $BATS_TEST_TMPDIR/bin/baz

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BATS_TEST_TMPDIR | sed "s|$USER/$(id -gn)|root/root|g" | sed "/bin\/baz/s|root/root|slacker/root|")

  run check

  assert_output "error strange-owner-or-group bin/baz slacker/root"
}

@test "Check logs error when incorrect owner for /lib" {
  create_empty_package $BATS_TEST_TMPDIR
  rm -rf $BATS_TEST_TMPDIR/lib

  mkdir -p $BATS_TEST_TMPDIR/lib

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BATS_TEST_TMPDIR | sed "s|$USER/$(id -gn)|root/root|g" | sed "/lib/s|root/root|slacker/root|")

  run check

  assert_output "error strange-owner-or-group lib/ slacker/root"
}

@test "Check logs error when incorrect owner for file in /lib" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/lib
  touch $BATS_TEST_TMPDIR/lib/baz

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BATS_TEST_TMPDIR | sed "s|$USER/$(id -gn)|root/root|g" | sed "/lib\/baz/s|root/root|slacker/root|")

  run check

  assert_output "error strange-owner-or-group lib/baz slacker/root"
}

@test "Check logs error when incorrect owner for /lib64" {
  create_empty_package $BATS_TEST_TMPDIR
  rm -rf $BATS_TEST_TMPDIR/lib64

  mkdir -p $BATS_TEST_TMPDIR/lib64

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BATS_TEST_TMPDIR | sed "s|$USER/$(id -gn)|root/root|g" | sed "/lib64/s|root/root|slacker/root|")

  run check

  assert_output "error strange-owner-or-group lib64/ slacker/root"
}

@test "Check logs error when incorrect owner for file in /lib64" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/lib64
  touch $BATS_TEST_TMPDIR/lib64/baz

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BATS_TEST_TMPDIR | sed "s|$USER/$(id -gn)|root/root|g" | sed "/lib64\/baz/s|root/root|slacker/root|")

  run check

  assert_output "error strange-owner-or-group lib64/baz slacker/root"
}

@test "Check logs error when incorrect owner for /sbin" {
  create_empty_package $BATS_TEST_TMPDIR
  rm -rf $BATS_TEST_TMPDIR/usr

  mkdir -p $BATS_TEST_TMPDIR/sbin

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BATS_TEST_TMPDIR | sed "s|$USER/$(id -gn)|root/root|g" | sed "/sbin/s|root/root|slacker/root|")

  run check

  assert_output "error strange-owner-or-group sbin/ slacker/root"
}

@test "Check logs error when incorrect owner for file in /sbin" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/sbin
  touch $BATS_TEST_TMPDIR/sbin/baz

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BATS_TEST_TMPDIR | sed "s|$USER/$(id -gn)|root/root|g" | sed "/sbin\/baz/s|root/root|slacker/root|")

  run check

  assert_output "error strange-owner-or-group sbin/baz slacker/root"
}

@test "Check logs error when incorrect owner for /usr" {
  create_empty_package $BATS_TEST_TMPDIR
  rm -rf $BATS_TEST_TMPDIR/usr/bin

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BATS_TEST_TMPDIR | sed "s|$USER/$(id -gn)|root/root|g" | sed "/usr/s|root/root|slacker/root|")

  run check

  assert_output "error strange-owner-or-group usr/ slacker/root"
}

@test "Check logs error when incorrect owner for file in /usr" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BATS_TEST_TMPDIR | sed "s|$USER/$(id -gn)|root/root|g" | sed "/usr\/bin\/foo/s|root/root|slacker/root|")

  run check

  assert_output "error strange-owner-or-group usr/bin/foo slacker/root"
}

@test "Check logs error when incorrect owner for /" {
  create_empty_package $BATS_TEST_TMPDIR
  rm -rf $BATS_TEST_TMPDIR/usr

  WORKING_DIR=$BATS_TEST_TMPDIR
  PKG_DETAILED_LISTING=$(create_detailed_tar_listing $BATS_TEST_TMPDIR | sed "s|$USER/$(id -gn)|root/root|g" | sed "/\.\//s|root/root|slacker/root|")

  run check

  assert_output "error strange-owner-or-group ./ slacker/root"
}
