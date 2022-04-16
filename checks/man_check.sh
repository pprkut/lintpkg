#!/bin/sh
# Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
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
    done <<< "$(find "$i" -type f ! -name "*.*.gz")"
  done <<< "$(find "$WORKING_DIR" -type d \( -path "*/man/man?*" -o -path "*/man/*/man?*" \))"
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
