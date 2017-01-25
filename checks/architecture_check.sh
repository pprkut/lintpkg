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

  case "$PKG_ARCH" in

    x86_64 )
      if [ -d "$WORKING_DIR/usr/lib" ]; then
        while read file && ! [ -z "$file" ]; do
          type=$(file "$file" | grep "ELF 64-bit")
          if ! [ -z "$type" ]; then
            log_error "binary-in-wrong-architecture-specific-path" "$file"
          fi
        done <<< "$(find "$WORKING_DIR/usr/lib" ! -type d)"
      fi
      ;;

    i[3456]86 )
      if [ -d "$WORKING_DIR/usr/lib64" ]; then
        while read file && ! [ -z "$file" ]; do
          type=$(file "$file" | grep "ELF 32-bit")
          if ! [ -z "$type" ]; then
            log_error "binary-in-wrong-architecture-specific-path" "$file"
          fi
        done <<< "$(find "$WORKING_DIR/usr/lib64" ! -type d)"
      fi
      ;;

    arm64* )
      # arm64 doesn't exist yet, this is a placeholder to document that
      # the entry for arm* below is 32-bit only.
      : ;;

    arm* )
      if [ -d "$WORKING_DIR/usr/lib64" ]; then
        while read file && ! [ -z "$file" ]; do
          type=$(file "$file" | grep "ELF 32-bit")
          if ! [ -z "$type" ]; then
            log_error "binary-in-wrong-architecture-specific-path" "$file"
          fi
        done <<< "$(find "$WORKING_DIR/usr/lib64" ! -type d)"
      fi
      ;;

    noarch | fw )
      # todo: check there's nothing arch-specific
      : ;;

    '' )
      # null string returned by package_element => can't check
      : ;;

    * )
      log_error "package-has-unrecognised-arch" "$PKG_ARCH"
      ;;

  esac

}

info() {
  if [ "$1" = "binary-in-wrong-architecture-specific-path" ]; then
    echo -n "There is a binary in the wrong architecture specific path. /usr/lib "
    echo -n "should not contain 64-bit binaries, /usr/lib64 should not contain "
    echo "32-bit binaries."
    echo
  elif [ "$1" = "package-has-unrecognised-arch" ]; then
    echo "The ARCH field of the package name is not a recognised arch."
    echo
  fi
}
