#!/bin/sh
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

check() {
  log_warning "whitespace-warning" "/path/t o/a file"
}

info() {
  if [ "$1" = "whitespace-warning" ]; then
    echo "A warning for a path containing whitespaces"
    echo
  fi
}
