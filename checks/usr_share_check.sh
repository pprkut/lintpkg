#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2014  B. Watson, Earth, The Milky Way Galaxy
# SPDX-License-Identifier: BSD-1-Clause

# Complain if binaries are installed in /usr/share.

check() {
  local n type

  for n in "${!PKG_FILES[@]}"; do
    type=${PKG_FILE_TYPES[n]}

    if [[ ${PKG_FILES[n]} == usr/share/* && ($type == *ELF* || $type == *"current ar archive"*) ]]; then
      log_path_error "binary-in-usr-share" "${PKG_FILES[n]}"
    fi
  done
}

info() {
  if [ "$1" = "binary-in-usr-share" ]; then
    echo -n "The /usr/share directory is for architecture-independent "
    echo -n "data, and should not contain object code such as ELF executables "
    echo "or shared libraries."
    echo
  fi
}
