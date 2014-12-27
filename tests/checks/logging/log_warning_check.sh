#!/bin/sh

check() {
  log_warning "simple-warning" "/path/to/file"
}

info() {
  if [ "$1" = "simple-warning" ]; then
    echo "A warning for a simple path"
    echo
  fi
}
