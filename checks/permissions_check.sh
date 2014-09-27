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

# Verify that directory/file permissions within a package are sane.

check() {
  # Check permissions under /usr
  if [ -d "$WORKING_DIR/usr" ]; then
    for file in $(find $WORKING_DIR/usr); do
      if [ -d "$file" ]; then
        permission=$(stat -c "%a" "$file")

        if ! [ "$permission" = "755" ]; then
            log_warning "strange-permission" "$file $permission"
        fi
      fi
    done
  fi

  # Check permissions under /etc
  if [ -d "$WORKING_DIR/etc" ]; then
    permission=$(stat -c "%a" "$WORKING_DIR/etc")
    if ! [ "$permission" = "755" ]; then
      log_warning "strange-permission" "$file $permission"
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
