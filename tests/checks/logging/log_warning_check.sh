#!/bin/sh
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

check() {
  log_warning "simple-warning" "/path/to/file"
}

info() {
  if [ "$1" = "simple-warning" ]; then
    echo "A warning for a simple path"
    echo
  fi
}
