#!/usr/bin/env bats

load ../../../helpers/assertions
load ../../../helpers/locations
load ../../../helpers/main
load ../../../helpers/makepkg
load ../../../helpers/mock-loggers

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

setup() {
  . "$LIVE_CHECKS/disallowed_dirs_check.sh"
}

@test "Show explanation for dir-or-file-in-home error" {
  run info "dir-or-file-in-home"

  assert_output "/home is intended for user specific data. You should not ship files under /home within a package."
}

@test "Show explanation for dir-or-file-in-mnt error" {
  run info "dir-or-file-in-mnt"

  assert_output "/mnt is intended to temporarily mount filesystems as needed. You should not ship files under /mnt within a package."
}

@test "Show explanation for dir-or-file-in-tmp error" {
  run info "dir-or-file-in-tmp"

  assert_output "/tmp is intended for transient temporary files. You should not ship files under /tmp within a package."
}

@test "Show explanation for dir-or-file-in-usr-local error" {
  run info "dir-or-file-in-usr-local"

  assert_output "/usr/local is intended for locally compiled applications and libraries that are not installed from packages. You should not ship files under /usr/local within a package."
}

@test "Show explanation for dir-or-file-in-usr-tmp error" {
  run info "dir-or-file-in-usr-tmp"

  assert_output "/usr/tmp is intended for more persistant temporary files than /tmp. You should not ship files under /usr/tmp within a package."
}

@test "Show explanation for dir-or-file-in-var-local error" {
  run info "dir-or-file-in-var-local"

  assert_output "/var/local is intended for variable data from apps installed in /usr/local. You should not ship files under /var/local within a package."
}

@test "Show explanation for dir-or-file-in-var-lock error" {
  run info "dir-or-file-in-var-lock"

  assert_output "/var/lock is intended for lock files. You should not ship files under /var/lock within a package."
}

@test "Show explanation for dir-or-file-in-var-run error" {
  run info "dir-or-file-in-var-run"

  assert_output "/var/run is intended for runtime variable data. You should not ship files under /var/run within a package."
}

@test "Show explanation for dir-or-file-in-var-tmp error" {
  run info "dir-or-file-in-var-tmp"

  assert_output "/var/tmp is intended for more persistant temporary files than /tmp. You should not ship files under /var/tmp within a package."
}
