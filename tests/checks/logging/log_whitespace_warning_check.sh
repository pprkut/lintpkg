#!/bin/sh

check() {
  log_warning "whitespace-warning" "/path/t o/a file"
}

info() {
  if [ "$1" = "whitespace-warning" ]; then
    echo "A warning for a path containing whitespaces"
    echo
  fi
}
