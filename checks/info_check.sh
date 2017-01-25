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

  while read infopage && ! [ -z "$infopage" ]; do
    log_warning "uncompressed-info-page" "$infopage"
  done <<< "$(echo $PACKAGE_LISTING | grep -E '/info/.*\.info(-[0-9]+)?$')"

  if [ -f $WORKING_DIR/usr/info/dir ]; then
    log_error "found-info-dir-file" "/usr/info/dir"
  fi

  if [ -d $WORKING_DIR/usr/info ]; then
    if [ -e $WORKING_DIR/install/doinst.sh ]; then
      if ! [ $(grep install-info $WORKING_DIR/install/doinst.sh | wc -l) -ge "2" ]; then
        log_error "missing-install-info"
      fi
    else
      log_error "missing-install-info"
    fi
  fi
}

info() {
  if [ "$1" = "incorrect-info-dir" ]; then
    echo "Info-pages should be put under /usr/info"
    echo
  elif [ "$1" = "uncompressed-info-page" ]; then
    echo "Info-pages should be gzip-compressed"
    echo
  elif [ "$1" = "found-info-dir-file" ]; then
    echo "The Info pages' \"dir\" file should not be included in the package."
    echo
  elif [ "$1" = "missing-install-info" ]; then
    echo -n "Whenever installing new Info pages in /usr/info, install-info"
    echo "should be run in doinst.sh."
    echo
  fi
}
