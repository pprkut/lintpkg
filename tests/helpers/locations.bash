#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause
# shellcheck disable=SC2034 # Used by the tests loading this file

REPO_ROOT="$(dirname "${BASH_SOURCE[0]}")/../../"

TEST_CHECKS="$(dirname "${BASH_SOURCE[0]}")/../checks"
TEST_STATICS="$(dirname "${BASH_SOURCE[0]}")/../statics"
DOCS="$(dirname "${BASH_SOURCE[0]}")/../../docs"

LIVE_CHECKS="$(dirname "${BASH_SOURCE[0]}")/../../checks"
