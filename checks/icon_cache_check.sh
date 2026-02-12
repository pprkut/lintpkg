#!/bin/sh
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

# Verify that icons are handled correctly.

check() {
  if [ -e $WORKING_DIR/usr/share/icons/hicolor ]; then
    if [ -e $WORKING_DIR/install/doinst.sh ]; then
      if ! [ $(grep hicolor $WORKING_DIR/install/doinst.sh | wc -l) -ge "2" ]; then
        log_error "missing-icon-cache-update" "hicolor"
      fi
    else
      log_error "missing-icon-cache-update" "hicolor"
    fi
  fi
}

info() {
  if [ "$1" = "missing-icon-cache-update" ]; then
    echo -n "Icon theme contents are cached in an mmap()-able cache file. Whenever "
    echo "installing new icons, this cache file should be updated in doinst.sh."
    echo
  fi
}
