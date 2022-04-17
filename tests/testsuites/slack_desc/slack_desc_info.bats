#!/usr/bin/env bats

load ../../helpers/locations
load ../../helpers/makepkg
load ../../helpers/mock_loggers

setup() {
  . "$LIVE_CHECKS/slack-desc_check.sh"
}

@test "show explanation for slack-desc-not-found error" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "slack-desc-not-found"

  [ "${lines[0]}" == "The package does not contain a slack-desc file in the install/ directory." ]

  rm -rf "$BASE"
}

@test "show explanation for slack-desc-description-wrong-packagename error" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "slack-desc-description-wrong-packagename"

  [ "${lines[0]}" == "The package name in the slack-desc file is not the same as the actual package name." ]

  rm -rf "$BASE"
}

@test "show explanation for slack-desc-invalid-number-of-lines error" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "slack-desc-invalid-number-of-lines"

  [ "${lines[0]}" == "The slack-desc file has the wrong number of lines of description. There should normally be 11 lines." ]

  rm -rf "$BASE"
}

@test "show explanation for slack-desc-description-lines-too-long" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "slack-desc-description-lines-too-long"

  [ "${lines[0]}" == "At least one of the description lines in the slack-desc file is too long. Please use the handy-ruler to determine the correct length." ]

  rm -rf "$BASE"
}

@test "show explanation for slack-desc-handy-ruler-misaligned" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "slack-desc-handy-ruler-misaligned"

  [ "${lines[0]}" == "The handy-ruler in the slack-desc file is misaligned." ]

  rm -rf "$BASE"
}

@test "show explanation for slack-desc-handy-ruler-broken" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "slack-desc-handy-ruler-broken"

  [ "${lines[0]}" == "The handy-ruler in the slack-desc file is broken (e.g., too long or too short)." ]

  rm -rf "$BASE"
}

@test "show explanation for slack-desc-unrecognised-text" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "slack-desc-unrecognised-text"

  [ "${lines[0]}" == "The slack-desc file contains some unrecognisable text." ]

  rm -rf "$BASE"
}
