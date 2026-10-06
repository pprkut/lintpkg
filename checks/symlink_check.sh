#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-FileCopyrightText: Copyright 2014  David Spencer, Baildon, West Yorkshire, U.K.
# SPDX-License-Identifier: BSD-1-Clause

# Verify that there are no symlinks in the package.

check() {
  while read symlink && ! [ -z "$symlink" ]; do
    log_path_warning "package-contains-symlink" "$symlink"
  done <<< "$(find "$WORKING_DIR" -type l | sort)"
}

info() {
  if [ "$1" = "package-contains-symlink" ]; then
    echo "Symbolic link found. These should normally be removed by makepkg."
    echo
  fi
}
