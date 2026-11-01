#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

# A check that reports what a previous check left behind:
check() {
  if [ -n "$LEAKED_VARIABLE" ]; then
    log_error "leaked-variable"
  fi

  if declare -F leak_helper > /dev/null; then
    log_error "leaked-function"
  fi

  if ! [ "$(pwd)" = "$WORKING_DIR" ]; then
    log_error "leaked-directory"
  fi

  log_warning "isolated-warning"
}
