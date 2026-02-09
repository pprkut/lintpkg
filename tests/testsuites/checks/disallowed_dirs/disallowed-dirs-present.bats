#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/disallowed_dirs_check.sh"
}

@test "Check logs error when package contains files under /home" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/home/user
  touch $BATS_TEST_TMPDIR/home/user/foo

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "error dir-or-file-in-home $BATS_TEST_TMPDIR//home/user"
  expect_output "error dir-or-file-in-home $BATS_TEST_TMPDIR//home/user/foo"

  assert_expected_output
}

@test "Check logs error when package contains files under /mnt" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/mnt/hd
  touch $BATS_TEST_TMPDIR/mnt/hd/foo

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "error dir-or-file-in-mnt $BATS_TEST_TMPDIR//mnt/hd"
  expect_output "error dir-or-file-in-mnt $BATS_TEST_TMPDIR//mnt/hd/foo"

  assert_expected_output
}

@test "Check logs error when package contains files under /tmp" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/tmp/foo
  touch $BATS_TEST_TMPDIR/tmp/foo/bar

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "error dir-or-file-in-tmp $BATS_TEST_TMPDIR//tmp/foo"
  expect_output "error dir-or-file-in-tmp $BATS_TEST_TMPDIR//tmp/foo/bar"

  assert_expected_output
}

@test "Check logs error when package contains files under /usr/local" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/local/bin
  touch $BATS_TEST_TMPDIR/usr/local/bin/foo

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "error dir-or-file-in-usr-local $BATS_TEST_TMPDIR//usr/local/bin"
  expect_output "error dir-or-file-in-usr-local $BATS_TEST_TMPDIR//usr/local/bin/foo"

  assert_expected_output
}

@test "Check logs error when package contains files under /usr/tmp" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/tmp/foo
  touch $BATS_TEST_TMPDIR/usr/tmp/foo/bar

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "error dir-or-file-in-usr-tmp $BATS_TEST_TMPDIR//usr/tmp/foo"
  expect_output "error dir-or-file-in-usr-tmp $BATS_TEST_TMPDIR//usr/tmp/foo/bar"

  assert_expected_output
}

@test "Check logs error when package contains files under /var/local" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/var/local/bar
  touch $BATS_TEST_TMPDIR/var/local/bar/foo

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "error dir-or-file-in-var-local $BATS_TEST_TMPDIR//var/local/bar"
  expect_output "error dir-or-file-in-var-local $BATS_TEST_TMPDIR//var/local/bar/foo"

  assert_expected_output
}

@test "Check logs error when package contains files under /var/lock" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/var/lock/bar
  touch $BATS_TEST_TMPDIR/var/lock/bar/foo

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "error dir-or-file-in-var-lock $BATS_TEST_TMPDIR//var/lock/bar"
  expect_output "error dir-or-file-in-var-lock $BATS_TEST_TMPDIR//var/lock/bar/foo"

  assert_expected_output
}

@test "Check logs error when package contains files under /var/run" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/var/run/bar
  touch $BATS_TEST_TMPDIR/var/run/bar/foo

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "error dir-or-file-in-var-run $BATS_TEST_TMPDIR//var/run/bar"
  expect_output "error dir-or-file-in-var-run $BATS_TEST_TMPDIR//var/run/bar/foo"

  assert_expected_output
}

@test "Check logs error when package contains files under /var/tmp" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/var/tmp/bar
  touch $BATS_TEST_TMPDIR/var/tmp/bar/foo

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  expect_output "error dir-or-file-in-var-tmp $BATS_TEST_TMPDIR//var/tmp/bar"
  expect_output "error dir-or-file-in-var-tmp $BATS_TEST_TMPDIR//var/tmp/bar/foo"

  assert_expected_output
}
