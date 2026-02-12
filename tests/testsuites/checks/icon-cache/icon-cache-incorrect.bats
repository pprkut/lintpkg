#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2022  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/icon_cache_check.sh"
}

@test "Check logs error when doinst.sh is missing" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/share/icons/hicolor

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "error missing-icon-cache-update hicolor"
}

@test "Check logs error when doinst.sh has unconditional update for hicolor icon cache" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/share/icons/hicolor
  cp $TEST_STATICS/doinst.sh/invalid-hicolor-icon-cache-unconditional $BATS_TEST_TMPDIR/install/doinst.sh

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "error missing-icon-cache-update hicolor"
}
