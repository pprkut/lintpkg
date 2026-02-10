#!/usr/bin/env bats
# SPDX-FileCopyrightText: Copyright 2022  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/slack_desc_check.sh"
}

@test "Show explanation for slack-desc-not-found error" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  run info "slack-desc-not-found"

  assert_output "The package does not contain a slack-desc file in the install/ directory."
}

@test "Show explanation for slack-desc-description-wrong-packagename error" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  run info "slack-desc-description-wrong-packagename"

  assert_output "The package name in the slack-desc file is not the same as the actual package name."
}

@test "Show explanation for slack-desc-invalid-number-of-lines error" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  run info "slack-desc-invalid-number-of-lines"

  assert_output "The slack-desc file has the wrong number of lines of description. There should normally be 11 lines."
}

@test "Show explanation for slack-desc-description-lines-too-long" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  run info "slack-desc-description-lines-too-long"

  assert_output "At least one of the description lines in the slack-desc file is too long. Please use the handy-ruler to determine the correct length."
}

@test "Show explanation for slack-desc-handy-ruler-misaligned" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  run info "slack-desc-handy-ruler-misaligned"

  assert_output "The handy-ruler in the slack-desc file is misaligned."
}

@test "Show explanation for slack-desc-handy-ruler-broken" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  run info "slack-desc-handy-ruler-broken"

  assert_output "The handy-ruler in the slack-desc file is broken (e.g., too long or too short)."
}

@test "Show explanation for slack-desc-unrecognised-text" {
  create_empty_package $BATS_TEST_TMPDIR

  WORKING_DIR=$BATS_TEST_TMPDIR

  run info "slack-desc-unrecognised-text"

  assert_output "The slack-desc file contains some unrecognisable text."
}
