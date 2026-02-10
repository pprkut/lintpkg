#!/bin/sh
# SPDX-FileCopyrightText: Copyright 2014  B. Watson, Earth, The Milky Way Galaxy
# SPDX-License-Identifier: BSD-1-Clause

# Complain if binaries are installed in /usr/share.

check() {
  [ -d $WORKING_DIR/usr/share ] && \
  while read file && ! [ -z "$file" ]; do
    if file "$file" | egrep -q '(ELF|current ar archive)'; then
      log_error "binary-in-usr-share" "$file"
    fi
  done <<< "$(find $WORKING_DIR/usr/share -type f)"
}

info() {
  if [ "$1" = "binary-in-usr-share" ]; then
    echo -n "The /usr/share directory is for architecture-independent "
    echo -n "data, and should not contain object code such as ELF executables "
    echo "or shared libraries."
    echo
  fi
}
