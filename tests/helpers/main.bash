#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

test_suite_name() {
  local suite_name
  suite_name=$(basename "${BATS_TEST_DIRNAME}")

  printf '%s' "${suite_name}"
}

# Prefix the names of all tests with their suite. Read by bats:
# shellcheck disable=SC2034
BATS_TEST_NAME_PREFIX="[$(test_suite_name)] "
