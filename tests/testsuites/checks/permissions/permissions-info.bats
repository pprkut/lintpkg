#!/usr/bin/env bats

TESTSUITE="permissions"

load ../../../helpers/locations
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/permissions_check.sh"
}

@test "[$TESTSUITE] Show explanation for strange-permission warning" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE

  WORKING_DIR=$BASE

  run info "strange-permission"

  [ "${lines[0]}" == "A file that you listed to include in your package has strange permissions. Usually, a file should have 0644 permissions and directories should have 0755 permissions." ]

  rm -rf "$BASE"
}
