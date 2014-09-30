#!/bin/sh
# Copyright 1994, 1998, 2000  Patrick Volkerding, Concord, CA, USA 
# Copyright 2001, 2003  Slackware Linux, Inc., Concord, CA, USA
# Copyright 2007, 2009, 2011  Patrick Volkerding, Sebeka, MN, USA 
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

# Verify that the package is tar-1.13 compatible.

check() {
  if [ "$(echo "$PKG_LISTING" | grep '^\./' | wc -l | tr -d ' ')" != "1" ]; then
    # <quote> Some dumb bunny built a package with something other than makepkg.  Bad! </quote>
    log_error "package-not-tar-113"
  fi
}

info() {
  if [ "$1" = "package-not-tar-113" ]; then
    echo -n "The package does not have tar-1.13 format member names. "
    echo "It was not created with makepkg."
    echo
  fi
}
