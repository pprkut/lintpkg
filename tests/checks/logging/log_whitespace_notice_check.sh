#!/bin/sh

check() {
  log_notice "whitespace-notice" "/path/t o/a file"
}

info() {
  if [ "$1" = "whitespace-notice" ]; then
    echo "A notice for a path containing whitespaces"
    echo
  fi
}
