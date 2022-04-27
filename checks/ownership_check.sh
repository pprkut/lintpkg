#!/bin/sh
# Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# Copyright 2014  David Spencer, Baildon, West Yorkshire, U.K.
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
