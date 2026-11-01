#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2014  B. Watson, Earth, The Milky Way Galaxy
# SPDX-License-Identifier: BSD-1-Clause

# Complain if binaries/libraries are unstripped.

check() {
  local n type

  for n in "${!PKG_FILES[@]}"; do
    type=${PKG_FILE_TYPES[n]}

    if [[ ($type == *executable* || $type == *"shared object"*) && $type == *ELF*"not stripped"* ]]; then
      log_path_warning "unstripped-binary" "${PKG_FILES[n]}"
    fi
  done
}

info() {
  if [ "$1" = "unstripped-binary" ]; then
    echo "ELF binaries and shared libraries are normally stripped, on Slackware."
  fi
}
