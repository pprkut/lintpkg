#!/bin/sh
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

check() {
  log_notice "whitespace-notice" "/path/t o/a file"
}

info() {
  if [ "$1" = "whitespace-notice" ]; then
    echo "A notice for a path containing whitespaces"
    echo
  fi
}
