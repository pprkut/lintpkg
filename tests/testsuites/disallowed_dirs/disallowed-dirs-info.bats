#!/usr/bin/env bats

TESTSUITE="disallowed_dirs"

load ../../helpers/locations
load ../../helpers/makepkg
load ../../helpers/mock-loggers

setup() {
  . "$LIVE_CHECKS/disallowed_dirs_check.sh"
}

@test "[$TESTSUITE] Show explanation for dir-or-file-in-home error" {
  run info "dir-or-file-in-home"

  [ "${lines[0]}" == "/home is intended for user specific data. You should not ship files under /home within a package." ]
}

@test "[$TESTSUITE] Show explanation for dir-or-file-in-mnt error" {
  run info "dir-or-file-in-mnt"

  [ "${lines[0]}" == "/mnt is intended to temporarily mount filesystems as needed. You should not ship files under /mnt within a package." ]
}

@test "[$TESTSUITE] Show explanation for dir-or-file-in-tmp error" {
  run info "dir-or-file-in-tmp"

  [ "${lines[0]}" == "/tmp is intended for transient temporary files. You should not ship files under /tmp within a package." ]
}

@test "[$TESTSUITE] Show explanation for dir-or-file-in-usr-local error" {
  run info "dir-or-file-in-usr-local"

  [ "${lines[0]}" == "/usr/local is intended for locally compiled applications and libraries that are not installed from packages. You should not ship files under /usr/local within a package." ]
}

@test "[$TESTSUITE] Show explanation for dir-or-file-in-usr-tmp error" {
  run info "dir-or-file-in-usr-tmp"

  [ "${lines[0]}" == "/usr/tmp is intended for more persistant temporary files than /tmp. You should not ship files under /usr/tmp within a package." ]
}

@test "[$TESTSUITE] Show explanation for dir-or-file-in-var-local error" {
  run info "dir-or-file-in-var-local"

  [ "${lines[0]}" == "/var/local is intended for variable data from apps installed in /usr/local. You should not ship files under /var/local within a package." ]
}

@test "[$TESTSUITE] Show explanation for dir-or-file-in-var-lock error" {
  run info "dir-or-file-in-var-lock"

  [ "${lines[0]}" == "/var/lock is intended for lock files. You should not ship files under /var/lock within a package." ]
}

@test "[$TESTSUITE] Show explanation for dir-or-file-in-var-run error" {
  run info "dir-or-file-in-var-run"

  [ "${lines[0]}" == "/var/run is intended for runtime variable data. You should not ship files under /var/run within a package." ]
}

@test "[$TESTSUITE] Show explanation for dir-or-file-in-var-tmp error" {
  run info "dir-or-file-in-var-tmp"

  [ "${lines[0]}" == "/var/tmp is intended for more persistant temporary files than /tmp. You should not ship files under /var/tmp within a package." ]
}
