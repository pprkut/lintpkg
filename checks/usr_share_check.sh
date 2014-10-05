#!/bin/sh
# Copyright 2014  B. Watson, Earth, The Milky Way Galaxy
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

# Complain if binaries are installed in /usr/share.

check() {
  [ -d $WORKING_DIR/usr/share ] && \
  while read file && ! [ -z "$file" ]; do
    if file "$file" | egrep -q '(ELF|current ar archive)'; then
      log_error "binary-in-usr-share" "$file"
    fi
  done <<< "$(find $WORKING_DIR/usr/share -type f)"
}

info() {
  if [ "$1" = "binary-in-usr-share" ]; then
    echo -n "The /usr/share directory is for architecture-independent "
    echo -n "data, and should not contain object code such as ELF executables "
    echo "or shared libraries."
    echo
  fi
}
