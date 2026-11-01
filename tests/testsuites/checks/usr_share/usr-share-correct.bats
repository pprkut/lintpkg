#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2022  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/usr_share_check.sh"
}

@test "Check logs no error when no binary in /usr/share" {
  create_empty_package "$BATS_TEST_TMPDIR"

  mkdir -p "$BATS_TEST_TMPDIR/usr/share/test"
  echo "foo" > "$BATS_TEST_TMPDIR/usr/share/test/bar.txt"

  create_file_types "$BATS_TEST_TMPDIR"

  run check

  refute_output
}

@test "Check logs no error when file name in /usr/share mentions ELF" {
  create_empty_package "$BATS_TEST_TMPDIR"

  mkdir -p "$BATS_TEST_TMPDIR/usr/share/doc/foo"
  echo "notes" > "$BATS_TEST_TMPDIR/usr/share/doc/foo/ELF-format.txt"

  create_file_types "$BATS_TEST_TMPDIR"

  run check

  refute_output
}
