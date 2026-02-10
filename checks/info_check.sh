#!/bin/sh
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

# Verify that info-pages are installed under /usr/info and check whether they
# are compressed.

check() {
  DIRECTORIES="/usr/share/info /usr/local/info /usr/local/share/info"

  for i in $DIRECTORIES; do
    if [ -e "$WORKING_DIR/$i" ]; then
      log_error "incorrect-info-dir" "$i"
    fi
  done

  while read i && ! [ -z "$i" ]; do
    while read infopage && ! [ -z "$infopage" ]; do
      log_warning "uncompressed-info-page" "$infopage"
    done <<< "$(find "$i" -type f ! -name "*.gz" ! -name "*.png")"
  done <<< "$(find "$WORKING_DIR" -type d -name "info")"
}

info() {
  if [ "$1" = "incorrect-info-dir" ]; then
    echo "Info-pages should be put under /usr/info"
    echo
  elif [ "$1" = "uncompressed-info-page" ]; then
    echo "Info-pages should be gzip-compressed"
    echo
  fi
}
