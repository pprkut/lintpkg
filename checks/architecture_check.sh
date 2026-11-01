#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

# Verify that the package content is correct in relation to its architecture.

check() {
  local n dir elf

  if [ "$PKG_ARCH" = "x86_64" ]; then
    dir="usr/lib"
    elf="ELF 64-bit"
  elif [ "$PKG_ARCH" = "i486" -o "$PKG_ARCH" = "i686" ]; then
    dir="usr/lib64"
    elf="ELF 32-bit"
  else
    return
  fi

  for n in "${!PKG_FILES[@]}"; do
    if [[ ${PKG_FILES[n]} == "$dir"/* && ${PKG_FILE_TYPES[n]} == *"$elf"* ]]; then
      log_path_error "binary-in-wrong-architecture-specific-path" "${PKG_FILES[n]}"
    fi
  done
}

info() {
  if [ "$1" = "binary-in-wrong-architecture-specific-path" ]; then
    echo -n "There is a binary in the wrong architecture specific path. /usr/lib "
    echo -n "should not contain 64-bit binaries, /usr/lib64 should not contain "
    echo "32-bit binaries."
    echo
  fi
}
