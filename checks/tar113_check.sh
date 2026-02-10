#!/bin/sh
# SPDX-FileCopyrightText: Copyright 1994, 1998, 2000  Patrick Volkerding, Concord, CA, USA
# SPDX-FileCopyrightText: Copyright 2001, 2003  Slackware Linux, Inc., Concord, CA, USA
# SPDX-FileCopyrightText: Copyright 2007, 2009, 2011  Patrick Volkerding, Sebeka, MN, USA
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-FileCopyrightText: Copyright 2014  David Spencer, Baildon, West Yorkshire, U.K.
# SPDX-License-Identifier: BSD-1-Clause

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
