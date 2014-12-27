#!/bin/sh

check() {
  log_error "simple-error" "/path/to/file"
}

info() {
  if [ "$1" = "simple-error" ]; then
    echo "A error for a simple path"
    echo
  fi
}
