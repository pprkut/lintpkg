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

# Verify that the package doesn't contain files in disallowed directories.

check() {
  DIRECTORIES="/home /mnt /tmp /usr/local /usr/tmp /var/local /var/lock /var/run /var/tmp"

  for i in $DIRECTORIES; do
    if [ -e "$WORKING_DIR/$i" ]; then
      normalized=$(echo $i | tr / -)
      find "$WORKING_DIR/$i" -mindepth 1 | while read item; do
        log_error "dir-or-file-in$normalized" "$item"
      done
    fi
  done

}

info() {
  if [ "$1" = "dir-or-file-in-home" ]; then
    echo -n "/home is intended for user specific data. You should not ship files under "
    echo "/home within a package."
    echo
  elif [ "$1" = "dir-or-file-in-mnt" ]; then
    echo -n "/mnt is intended to temporarily mount filesystems as needed. You should not "
    echo "ship files under /mnt within a package."
    echo
  elif [ "$1" = "dir-or-file-in-tmp" ]; then
    echo -n "/tmp is intended for transient temporary files. You should not ship files "
    echo "under /tmp within a package."
    echo
  elif [ "$1" = "dir-or-file-in-usr-local" ]; then
    echo -n "/usr/local is intended for locally compiled applications and libraries that "
    echo -n "are not installed from packages. You should not ship files under /usr/local "
    echo "within a package."
    echo
  elif [ "$1" = "dir-or-file-in-usr-tmp" ]; then
    echo -n "/usr/tmp is intended for more persistant temporary files than /tmp. You "
    echo "should not ship files under /usr/tmp within a package."
    echo
  elif [ "$1" = "dir-or-file-in-var-local" ]; then
    echo -n "/var/local is intended for variable data from apps installed in /usr/local. "
    echo "You should not ship files under /var/local within a package."
    echo
  elif [ "$1" = "dir-or-file-in-var-lock" ]; then
    echo -n "/var/lock is intended for lock files. You should not ship files under "
    echo "/var/lock within a package."
    echo
  elif [ "$1" = "dir-or-file-in-var-run" ]; then
    echo -n "/var/run is intended for runtime variable data. You should not ship files "
    echo "under /var/run within a package."
    echo
  elif [ "$1" = "dir-or-file-in-var-tmp" ]; then
    echo -n "/var/tmp is intended for more persistant temporary files than /tmp. You "
    echo "should not ship files under /var/tmp within a package."
    echo
  fi
}
