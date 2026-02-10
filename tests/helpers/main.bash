#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

test_suite_name() {
  local suite_name=$(basename ${BATS_TEST_DIRNAME})

  printf "${suite_name}"
}
