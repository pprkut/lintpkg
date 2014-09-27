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

# Verify that the package content is correct in relation to its architecture.

check() {
  if [ "$PKG_ARCH" = "x86_64" ]; then
    if [ -d "$WORKING_DIR/usr/lib" ]; then
      find "$WORKING_DIR/usr/lib" ! -type d | while read file; do
        type=$(file "$file" | grep "ELF 64-bit")
        if ! [ -z "$type" ]; then
          file=$(echo $file | sed "s|^$WORKING_DIR||")
          log_error "binary-in-wrong-architecture-specific-path" "$file"
        fi
      done
    fi
  fi

  if [ "$PKG_ARCH" = "i486" -o "$PKG_ARCH" = "i686" ]; then
    if [ -d "$WORKING_DIR/usr/lib64" ]; then
      find "$WORKING_DIR/usr/lib64" ! -type d | while read file; do
        type=$(file "$file" | grep "ELF 32-bit")
        if ! [ -z "$type" ]; then
          file=$(echo $file | sed "s|^$WORKING_DIR||")
          log_error "binary-in-wrong-architecture-specific-path" "$file"
        fi
      done
    fi
  fi
}

info() {
  if [ "$1" = "binary-in-wrong-architecture-specific-path" ]; then
    echo -n "There is a binary in the wrong architecture specific path. /usr/lib "
    echo -n "should not contain 64-bit binaries, /usr/lib64 should not contain "
    echo "32-bit binaries."
    echo
  fi
}
