#!/bin/sh
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

# Verify that the package content is correct in relation to its architecture.

check() {
  if [ "$PKG_ARCH" = "x86_64" ]; then
    if [ -d "$WORKING_DIR/usr/lib" ]; then
      while read file && ! [ -z "$file" ]; do
        type=$(file "$file" | grep "ELF 64-bit")
        if ! [ -z "$type" ]; then
          log_error "binary-in-wrong-architecture-specific-path" "$file"
        fi
      done <<< "$(find "$WORKING_DIR/usr/lib" ! -type d)"
    fi
  fi

  if [ "$PKG_ARCH" = "i486" -o "$PKG_ARCH" = "i686" ]; then
    if [ -d "$WORKING_DIR/usr/lib64" ]; then
      while read file && ! [ -z "$file" ]; do
        type=$(file "$file" | grep "ELF 32-bit")
        if ! [ -z "$type" ]; then
          log_error "binary-in-wrong-architecture-specific-path" "$file"
        fi
      done <<< "$(find "$WORKING_DIR/usr/lib64" ! -type d)"
    fi
  fi
}

info() {
  if [ "$1" = "binary-in-wrong-architecture-specific-path" ]; then
    echo -n "There is a binary in the wrong architecture specific path. /usr/lib "
    echo -n "should not contain 64-bit binaries, /usr/lib64 should not contain "
    echo "32-bit binaries."
    echo
  fi
}
