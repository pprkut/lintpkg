#!/bin/sh
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-FileCopyrightText: Copyright 2014  David Spencer, Baildon, West Yorkshire, U.K.
# SPDX-License-Identifier: BSD-1-Clause

# Verify that the 'install' directory exists.

check() {
  if [ ! -d "$WORKING_DIR/install" ]; then
    log_error "no-install-dir"
  fi
}

info() {
  if [ "$1" = "no-install-dir" ]; then
    echo -n "The file does not contain an install/ directory. It is probably "
    echo "not a Slackware package."
    echo
  fi
}
