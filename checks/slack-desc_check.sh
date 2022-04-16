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

# Verify that the slack-desc file exists and is correctly formatted.

check() {

  slackdescpath="$WORKING_DIR/install/slack-desc"
  if [ -f "$slackdescpath" ]; then

    # Check the description prefix
    descprefix=$(grep '^[^ #]*:' "$slackdescpath" | head -n 1 | sed 's/:.*//')
    if [ "$descprefix" != "${PKG_NAME}" ]; then
      log_error "slack-desc-description-wrong-packagename" "$descprefix"
    fi

    # Check the number of lines of description
    desclinecount=$(grep "^${descprefix}:" "$slackdescpath" | wc -l)
    # The traditional number is exactly 11, but recent installpkg allows <= 13
    desclinecountmin=3
    desclinecountmax=13
    if [ "$desclinecount" -lt $desclinecountmin ] || \
       [ "$desclinecount" -gt $desclinecountmax ]; then
      log_error "slack-desc-invalid-number-of-lines" "$desclinecount"
    fi

    # Check the description lines are not too long
    desclinelengthmax=71
    if [ $(grep "^${descprefix}:" "$slackdescpath" | sed "s/^${descprefix}://" | wc -L) -gt $desclinelengthmax ]; then
      log_error "slack-desc-description-lines-too-long"
    fi

    # check there's no other junk
    if grep -q -v -e '^ *#' -e "^${descprefix}:" -e '^ *$' -e '|-.*-|' "$slackdescpath" ; then
      log_error "slack-desc-unrecognised-text"
    fi

  else
    log_error "slack-desc-not-found"
  fi

}

info() {
  if [ "$1" = "slack-desc-not-found" ]; then
    echo -n "The package does not contain a slack-desc file in the install/ "
    echo "directory."
    echo
  elif [ "$1" = "slack-desc-description-wrong-packagename" ]; then
    echo -n "The package name in the slack-desc file is not the same as the "
    echo "actual package name."
    echo
  elif [ "$1" = "slack-desc-invalid-number-of-lines" ]; then
    echo -n "The slack-desc file has the wrong number of lines of description. "
    echo "There should normally be 11 lines."
    echo
  elif [ "$1" = "slack-desc-description-lines-too-long" ]; then
    echo -n "At least one of the description lines in the slack-desc file "
    echo -n "is too long. Please use the handy-ruler to determine the correct "
    echo "length."
    echo
  elif [ "$1" = "slack-desc-handy-ruler-misaligned" ]; then
    echo "The handy-ruler in the slack-desc file is misaligned."
    echo
  elif [ "$1" = "slack-desc-handy-ruler-broken" ]; then
    echo -n "The handy-ruler in the slack-desc file is broken "
    echo "(e.g., too long or too short)."
    echo
  elif [ "$1" = "slack-desc-unrecognised-text" ]; then
    echo "The slack-desc file contains some unrecognisable text."
    echo
  fi
}
