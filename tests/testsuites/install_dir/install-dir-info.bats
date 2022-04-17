#!/usr/bin/env bats

TESTSUITE="install_dir"

load ../../helpers/locations
load ../../helpers/makepkg
load ../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/install_dir_check.sh"
}

@test "[$TESTSUITE] Show explanation for no-install-dir error" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "no-install-dir"

  [ "${lines[0]}" == "The file does not contain an install/ directory. It is probably not a Slackware package." ]

  rm -rf "$BASE"
}

