#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2026  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

# A check that logs from within a pipeline, and so from a subshell:
check() {
  printf '%s\n' "/path/to/file" "/path/to/other file" | while read -r file; do
    log_path_error "pipeline-error" "$file"
  done

  echo "/path/to/file" | while read -r file; do
    log_path_warning "pipeline-warning" "$file"
  done
}
