#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

check() {
  echo "xattr: $(getfattr -n user.lintpkg --only-values "$WORKING_DIR/usr/bin/foo" 2> /dev/null)"
  echo "acl: $(getfacl -c "$WORKING_DIR/usr/bin/foo" 2> /dev/null | grep '^user:nobody:')"
}
