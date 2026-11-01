#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

# A check that leaves behind a global variable and a helper function, changes
# a variable of lintpkg and the current directory, and exits:
leak_helper() {
  echo "leaked"
}

# shellcheck disable=SC2034 # Leaving them behind is the point
check() {
  LEAKED_VARIABLE="leaked"
  PKG_FULLNAME="clobbered"
  cd /
  exit 1
}
