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
  . "$LIVE_CHECKS/shared_libraries_check.sh"
}

@test "Check logs error when libtool archive without header" {
  create_empty_package $BATS_TEST_TMPDIR

  mkdir -p $BATS_TEST_TMPDIR/usr/lib/app/private/

  sed '1,7d' $TEST_STATICS/shared-libraries/foo-ltmain.la > $BATS_TEST_TMPDIR/usr/lib/app/private/foo.la

  WORKING_DIR=$BATS_TEST_TMPDIR

  run check

  assert_output "error invalid-libtool-archive $BATS_TEST_TMPDIR/usr/lib/app/private/foo.la"
}
