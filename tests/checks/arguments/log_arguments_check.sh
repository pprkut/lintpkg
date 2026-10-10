#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

check() {
  log_error "glob-error" "*"
  log_error "whitespace-error" "a   b"
  log_error "option-error" "-n"
  log_error "path-error" "/path/to//file/"
}
