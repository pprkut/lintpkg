#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

check() {
  local n

  for n in "${!PKG_FILES[@]}"; do
    echo "${PKG_FILES[n]}|${PKG_FILE_TYPES[n]}"
  done
}
