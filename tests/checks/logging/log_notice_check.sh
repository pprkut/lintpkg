#!/bin/sh
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

check() {
  log_notice "simple-notice" "/path/to/file"
}

info() {
  if [ "$1" = "simple-notice" ]; then
    echo "A notice for a simple path"
    echo
  fi
}
