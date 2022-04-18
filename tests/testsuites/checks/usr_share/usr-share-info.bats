#!/usr/bin/env bats

TESTSUITE="usr_share"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/usr_share_check.sh"
}

@test "[$TESTSUITE] Show explanation for binary-in-usr-share" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "binary-in-usr-share"

  [ "${lines[0]}" == "The /usr/share directory is for architecture-independent data, and should not contain object code such as ELF executables or shared libraries." ]

  rm -rf "$BASE"
}
