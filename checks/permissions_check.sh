#!/bin/sh
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

# Verify that directory/file permissions within a package are sane.

check() {
  # Check permissions under /usr
  if [ -d "$WORKING_DIR/usr" ]; then
    while read file && ! [ -z "$file" ]; do
      if [ -d "$file" ]; then
        permission=$(stat -c "%a" "$file")

        if ! [ "$permission" = "755" ]; then
            log_warning "strange-permission" "$file" "$permission"
        fi
      fi
    done <<< "$(find "$WORKING_DIR/usr")"
  fi

  # Check permissions under /etc
  if [ -d "$WORKING_DIR/etc" ]; then
    permission=$(stat -c "%a" "$WORKING_DIR/etc")
    if ! [ "$permission" = "755" ]; then
      log_warning "strange-permission" "$WORKING_DIR/etc" "$permission"
    fi
  fi
}

info() {
  if [ "$1" = "strange-permission" ]; then
    echo -n "A file that you listed to include in your package has strange "
    echo -n "permissions. Usually, a file should have 0644 permissions and "
    echo "directories should have 0755 permissions."
    echo
  fi
}
