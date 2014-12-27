#!/bin/sh

check() {
  log_notice "simple-notice" "/path/to/file"
}

info() {
  if [ "$1" = "simple-notice" ]; then
    echo "A notice for a simple path"
    echo
  fi
}
