#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

check() {
  log_error "explained-error" "/path/to/file"
}

info() {
  if [ "$1" = "explained-error" ]; then
    echo "An error with an explanation"
    echo
  fi
}
