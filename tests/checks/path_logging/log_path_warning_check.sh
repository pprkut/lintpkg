#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

check() {
  log_path_warning "path-warning" "$WORKING_DIR/usr/bin/foo"
  log_path_warning "path-warning" "/usr/bin/foo"
  log_path_warning "path-warning" "usr/bin/foo"
  log_path_warning "path-warning" "usr/bin/"
  log_path_warning "path-warning" "./"
  log_path_warning "path-warning" "$WORKING_DIR//usr/bin/foo"
  log_path_warning "path-warning" "usr/t o/a file"
  log_path_warning "path-warning" "usr/bin/bar" "-> foo" "slacker/root"
}

info() {
  if [ "$1" = "path-warning" ]; then
    echo "A warning for a path within the package"
    echo
  fi
}
