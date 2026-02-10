#!/bin/sh
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

check() {
  log_notice "working-dir-notice" "$WORKING_DIR/usr/bin/foo"
}

info() {
  if [ "$1" = "working-dir-notice" ]; then
    echo "A notice for a simple path within the working directory"
    echo
  fi
}
