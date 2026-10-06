#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2022  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

log_error() {
  echo "error" $@
}

log_warning() {
  echo "warning" $@
}

log_notice() {
  echo "notice" $@
}

log_path_error() {
  echo "path-error" $@
}

log_path_warning() {
  echo "path-warning" $@
}

log_path_notice() {
  echo "path-notice" $@
}
