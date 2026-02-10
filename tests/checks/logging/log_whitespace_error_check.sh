#!/bin/sh
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

check() {
  log_error "whitespace-error" "/path/t o/a file"
}

info() {
  if [ "$1" = "whitespace-error" ]; then
    echo "A error for a path containing whitespaces"
    echo
  fi
}
