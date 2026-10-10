#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

# A check without explanations for its messages
check() {
  log_error "unexplained-error" "/path/to/file"
}
