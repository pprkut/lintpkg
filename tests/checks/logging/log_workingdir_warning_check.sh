#!/bin/sh

check() {
  log_warning "working-dir-warning" "$WORKING_DIR/usr/bin/foo"
}

info() {
  if [ "$1" = "working-dir-warning" ]; then
    echo "A warning for a simple path within the working directory"
    echo
  fi
}
