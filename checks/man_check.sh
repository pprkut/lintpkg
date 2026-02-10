#!/bin/sh
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

# Verify that man-pages are installed under /usr/man and check whether they
# are compressed.

check() {
  DIRECTORIES="/usr/share/man /usr/local/man /usr/local/share/man"

  for i in $DIRECTORIES; do
    if [ -e "$WORKING_DIR/$i" ]; then
      log_error "incorrect-man-dir" "$i"
    fi
  done

  while read i && ! [ -z "$i" ]; do
    while read manpage && ! [ -z "$manpage" ]; do
      log_warning "uncompressed-man-page" "$manpage"
    done <<< "$(find "$i" -type f ! -name "*.gz")"
  done <<< "$(find "$WORKING_DIR" -type d -name "man")"
}

info() {
  if [ "$1" = "incorrect-man-dir" ]; then
    echo "Man-pages should be put under /usr/man"
    echo
  elif [ "$1" = "uncompressed-man-page" ]; then
    echo "Man-pages should be gzip-compressed"
    echo
  fi
}
