#!/usr/bin/env bats

load ../../helpers/assertions
load ../../helpers/locations
load ../../helpers/main
load ../../helpers/makepkg

BATS_TEST_NAME_PREFIX="[$( test_suite_name )] "

@test "Checks have proper full package name" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_fullname_check "$PKG"

  assert_line -n 0 "empty-1.0-noarch-1"

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Checks have proper simple package name" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_name_check "$PKG"

  assert_line -n 0 "empty"

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Checks have proper package name with dash" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE lintpkg-empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_name_check "$PKG"

  assert_line -n 0 "lintpkg-empty"

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Checks have proper package name when version has dash" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE lintpkg-empty 1.0-1 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_name_check "$PKG"

  assert_line -n 0 "lintpkg-empty-1.0"

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Checks have proper simple package version" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_version_check "$PKG"

  assert_line -n 0 "1.0"

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Checks have proper package version when name has dash" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE lintpkg-empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_version_check "$PKG"

  assert_line -n 0 "1.0"

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Checks have proper package version when version has dash" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE lintpkg-empty 1.0-1 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_version_check "$PKG"

  assert_line -n 0 "1"

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Checks have proper package architecture" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_arch_check "$PKG"

  assert_line -n 0 "noarch"

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Checks have proper package build number" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 2)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_build_check "$PKG"

  assert_line -n 0 "2"

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Checks have proper package extension" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_extension_check "$PKG"

  assert_line -n 0 "tgz"

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Checks have proper simple package listing" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_listing_check "$PKG"

  EXPECTED=""
  EXPECTED+="./"$'\n'
  EXPECTED+="install/"$'\n'
  EXPECTED+="install/slack-desc"$'\n'
  EXPECTED+="usr/"$'\n'
  EXPECTED+="usr/bin/"$'\n'
  EXPECTED+="usr/bin/foo"

  assert_output --partial "$EXPECTED"

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Checks have proper detailed package listing" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  USER=$(id -u -n)
  GROUP=$(id -g -n)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_detailed_listing_check "$PKG"

  perm_dir='drwxr-xr-x'
  perm_file='-rw-r--r--'
  perm_exec='-rwxr-xr-x'
  owner="$USER/$GROUP"
  date='[0-9]{4}-[0-9]{2}-[0-9]{2}'
  time='[0-9]{2}:[0-9]{2}'
  whitespace='[[:blank:]]+'

  assert_line --index 0 --regexp "$perm_dir $owner${whitespace}0 $date $time ./"
  assert_line --index 1 --regexp "$perm_dir $owner${whitespace}0 $date $time install/"
  assert_line --index 2 --regexp "$perm_file $owner${whitespace}141 $date $time install/slack-desc"
  assert_line --index 3 --regexp "$perm_dir $owner${whitespace}0 $date $time usr/"
  assert_line --index 4 --regexp "$perm_dir $owner${whitespace}0 $date $time usr/bin/"
  assert_line --index 5 --regexp "$perm_exec $owner${whitespace}0 $date $time usr/bin/foo"

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Checks have default working directory" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_working_dir_check "$PKG"

  assert_line -n 0 --regexp '^/tmp/lintpkg\.......$'

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "Checks have working directory specified with -E" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  mkdir -p /tmp/lintpkg_test

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_working_dir_check -E "/tmp/lintpkg_test" "$PKG"

  assert_line -n 0 --regexp '^/tmp/lintpkg_test/lintpkg\.......$'

  rm -f "$PKG"
  rm -rf "$BASE"
  rm -rf /tmp/lintpkg_test
}

@test "Checks have working directory specified with --extractdir" {
  BASE=$(create_tmp_dir)

  refute [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  mkdir -p /tmp/lintpkg_test

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_working_dir_check --extractdir "/tmp/lintpkg_test" "$PKG"

  assert_line -n 0 --regexp '^/tmp/lintpkg_test/lintpkg\.......$'

  rm -f "$PKG"
  rm -rf "$BASE"
  rm -rf /tmp/lintpkg_test
}
