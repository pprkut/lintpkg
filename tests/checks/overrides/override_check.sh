#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

check() {
  log_path_error "path-error" "$WORKING_DIR/usr/bin/foo"
  log_path_warning "path-warning" "usr/bin/foo" "slacker/root"
  log_path_notice "path-notice" "/usr/bin/foo"
  log_error "subject-error" "hicolor"
  log_warning "single-warning" "12"
}

info() {
  if [ "$1" = "path-error" ]; then
    echo "An error for a path within the package"
    echo
  fi
}
