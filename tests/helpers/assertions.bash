#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

bats_load_library bats-assert
bats_load_library bats-file
bats_load_library bats-support

EXPECTED_OUTPUT=""

expect_output() {
  if ! [ -z "$EXPECTED_OUTPUT" ]; then
    EXPECTED_OUTPUT+=$'\n'
  fi

  EXPECTED_OUTPUT+="$1"
}

assert_expected_output() {
  assert_output "$@" "$EXPECTED_OUTPUT"
}
