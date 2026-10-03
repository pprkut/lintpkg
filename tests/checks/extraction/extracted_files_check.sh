#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

check() {
  cd "$WORKING_DIR"
    find . | LC_ALL=C sort
  cd - > /dev/null
}
