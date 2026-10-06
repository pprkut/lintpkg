#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

check() {
  log_path_error "path-error" "$WORKING_DIR/usr/bin/foo"
  log_path_error "path-error" "/usr/bin/foo"
  log_path_error "path-error" "usr/bin/foo"
  log_path_error "path-error" "usr/bin/"
  log_path_error "path-error" "./"
  log_path_error "path-error" "$WORKING_DIR//usr/bin/foo"
  log_path_error "path-error" "usr/t o/a file"
  log_path_error "path-error" "usr/bin/bar" "-> foo" "slacker/root"
}

info() {
  if [ "$1" = "path-error" ]; then
    echo "A error for a path within the package"
    echo
  fi
}
