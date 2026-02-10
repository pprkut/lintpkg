#!/bin/sh
# SPDX-FileCopyrightText: Copyright 2014  B. Watson, Earth, The Milky Way Galaxy
# SPDX-License-Identifier: BSD-1-Clause

# Complain if binaries/libraries are unstripped.

check() {
  while read file && ! [ -z "$file" ]; do
    if file "$file" | grep -e "executable" -e "shared object" | egrep -q 'ELF.*not stripped'; then
      log_warning "unstripped-binary" "$file"
    fi
  done <<< "$(find $WORKING_DIR -type f)"
}

info() {
  if [ "$1" = "unstripped-binary" ]; then
    echo "ELF binaries and shared libraries are normally stripped, on Slackware."
  fi
}
