#!/bin/sh

check() {
  log_error "working-dir-error" "$WORKING_DIR/usr/bin/foo"
}

info() {
  if [ "$1" = "working-dir-error" ]; then
    echo "A error for a simple path within the working directory"
    echo
  fi
}
