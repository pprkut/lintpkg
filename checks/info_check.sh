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

# Verify that info-pages are installed under /usr/info and check whether they
# are compressed.

check() {
  DIRECTORIES="/usr/share/info /usr/local/info /usr/local/share/info"

  for i in $DIRECTORIES; do
    if [ -e "$WORKING_DIR/$i" ]; then
      log_error "incorrect-info-dir" "$i"
    fi
  done

  find "$WORKING_DIR" -type d -name "info" | while read i; do
    find "$i" -type f ! -name "*.gz" ! -name "*.png" | while read infopage; do
      file=$(echo $infopage | sed "s|^$WORKING_DIR||")
      log_warning "uncompressed-info-page" "$file"
    done
  done

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
