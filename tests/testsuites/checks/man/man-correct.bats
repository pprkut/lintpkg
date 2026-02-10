#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2023  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/man_check.sh"
}

@test "Check logs no error when correct directory and compressed" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/man/man1
  cp $DOCS/lintpkg.1 $BATS_TEST_TMPDIR/usr/man/man1/
  gzip -9 $BATS_TEST_TMPDIR/usr/man/man1/lintpkg.1

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  refute_output
}
