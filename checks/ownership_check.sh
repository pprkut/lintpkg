#!/bin/sh
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-FileCopyrightText: Copyright 2014  David Spencer, Baildon, West Yorkshire, U.K.
# SPDX-License-Identifier: BSD-1-Clause

# Verify that object owners and groups within a package are sane.

check() {
  USER_WHITELIST="root daemon uucp"

  while read tperms owngrp size date time objname && ! [ -z "$tperms" ]; do
    OWNER=$(echo "$owngrp" | cut -d "/" -f 1)
    DIRECTORY=$(dirname "$objname")
    if [ "$DIRECTORY" = "usr/bin" -o "$DIRECTORY" = "usr/sbin" ]; then
      INCORRECT="yes"
      for user in $USER_WHITELIST; do
        if [ "$user" = "$OWNER" ]; then
          INCORRECT="no"
        fi
      done

      if [ "$INCORRECT" = "yes" ]; then
        log_error "strange-owner-or-group" "$objname" "$owngrp"
      fi

    elif ! [ "$OWNER" = "root" ]; then
      log_error "strange-owner-or-group" "$objname" "$owngrp"
    fi
  done <<< "$(echo "$PKG_DETAILED_LISTING" | \
                awk '$6~/^(bin\/|lib\/|lib64\/|sbin\/|usr\/|\.\/$)/' | \
                grep -v ' root/root ')"
}

info() {
  if [ "$1" = "strange-owner-or-group" ]; then
    echo "The owner and/or group of this object is not root:root."
    echo
  fi
}
