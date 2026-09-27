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

# Fail if the directory doesn't exist or isn't empty, and list its content.
assert_dir_empty() {
  local -r dir="$1"

  if ! [ -d "$dir" ]; then
    batslib_print_kv_single 4 'path' "$dir" \
      | batslib_decorate 'directory does not exist' \
      | fail
  elif [ -n "$(ls -A "$dir")" ]; then
    batslib_print_kv_single_or_multi 7 \
        'path' "$dir" \
        'content' "$(ls -A "$dir")" \
      | batslib_decorate 'directory is not empty' \
      | fail
  fi
}
