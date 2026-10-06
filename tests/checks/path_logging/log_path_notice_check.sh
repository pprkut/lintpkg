#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

check() {
  log_path_notice "path-notice" "$WORKING_DIR/usr/bin/foo"
  log_path_notice "path-notice" "/usr/bin/foo"
  log_path_notice "path-notice" "usr/bin/foo"
  log_path_notice "path-notice" "usr/bin/"
  log_path_notice "path-notice" "./"
  log_path_notice "path-notice" "$WORKING_DIR//usr/bin/foo"
  log_path_notice "path-notice" "usr/t o/a file"
  log_path_notice "path-notice" "usr/bin/bar" "-> foo" "slacker/root"
}

info() {
  if [ "$1" = "path-notice" ]; then
    echo "A notice for a path within the package"
    echo
  fi
}
