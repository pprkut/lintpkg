#!/bin/sh

check() {
  log_error "whitespace-error" "/path/t o/a file"
}

info() {
  if [ "$1" = "whitespace-error" ]; then
    echo "A error for a path containing whitespaces"
    echo
  fi
}
