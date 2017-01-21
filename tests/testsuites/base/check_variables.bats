#!/usr/bin/env bats

load ../../helpers/locations
load ../../helpers/makepkg

@test "checks have proper full package name" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_fullname_check "$PKG"

  [ "${lines[0]}" == "empty-1.0-noarch-1" ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "checks have proper simple package name" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_name_check "$PKG"

  [ "${lines[0]}" == "empty" ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "checks have proper package name with dash" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE lintpkg-empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_name_check "$PKG"

  [ "${lines[0]}" == "lintpkg-empty" ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "checks have proper package name when version has dash" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE lintpkg-empty 1.0-1 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_name_check "$PKG"

  [ "${lines[0]}" == "lintpkg-empty-1.0" ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "checks have proper simple package version" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_version_check "$PKG"

  [ "${lines[0]}" == "1.0" ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "checks have proper package version when name has dash" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE lintpkg-empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_version_check "$PKG"

  [ "${lines[0]}" == "1.0" ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "checks have proper package version when version has dash" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE lintpkg-empty 1.0-1 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_version_check "$PKG"

  [ "${lines[0]}" == "1" ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "checks have proper package architecture" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_arch_check "$PKG"

  [ "${lines[0]}" == "noarch" ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "checks have proper package build number" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 2)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_build_check "$PKG"

  [ "${lines[0]}" == "2" ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "checks have proper package extension" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_extension_check "$PKG"

  [ "${lines[0]}" == "tgz" ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "checks have proper simple package listing" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_listing_check "$PKG"

  [ "${lines[0]}" == "./" ]
  [ "${lines[1]}" == "usr/" ]
  [ "${lines[2]}" == "usr/bin/" ]
  [ "${lines[3]}" == "usr/bin/foo" ]
  [ "${lines[4]}" == "install/" ]
  [ "${lines[5]}" == "install/slack-desc" ]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "checks have proper detailed package listing" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  USER=$(id -u -n)
  GROUP=$(id -g -n)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_detailed_listing_check "$PKG"

  [[ "${lines[0]}" =~ "drwxr-xr-x $USER/$GROUP  0 "[0-9]{4}-[0-9]{2}-[0-9]{2}" "[0-9]{2}":"[0-9]{2}" ./" ]]
  [[ "${lines[1]}" =~ "drwxr-xr-x $USER/$GROUP  0 "[0-9]{4}-[0-9]{2}-[0-9]{2}" "[0-9]{2}":"[0-9]{2}" usr/" ]]
  [[ "${lines[2]}" =~ "drwxr-xr-x $USER/$GROUP  0 "[0-9]{4}-[0-9]{2}-[0-9]{2}" "[0-9]{2}":"[0-9]{2}" usr/bin/" ]]
  [[ "${lines[3]}" =~ "-rwxr-xr-x $USER/$GROUP  0 "[0-9]{4}-[0-9]{2}-[0-9]{2}" "[0-9]{2}":"[0-9]{2}" usr/bin/foo" ]]
  [[ "${lines[4]}" =~ "drwxr-xr-x $USER/$GROUP  0 "[0-9]{4}-[0-9]{2}-[0-9]{2}" "[0-9]{2}":"[0-9]{2}" install/" ]]
  [[ "${lines[5]}" =~ "-rw-r--r-- $USER/$GROUP 141 "[0-9]{4}-[0-9]{2}-[0-9]{2}" "[0-9]{2}":"[0-9]{2}" install/slack-desc" ]]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "checks have default working directory" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_working_dir_check "$PKG"

  [[ "${lines[0]}" =~ "/tmp/lintpkg."...... ]]

  rm -f "$PKG"
  rm -rf "$BASE"
}

@test "checks have working directory specified with -E" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  mkdir -p /tmp/lintpkg_test

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_working_dir_check -E "/tmp/lintpkg_test" "$PKG"

  [[ "${lines[0]}" =~ "/tmp/lintpkg_test/lintpkg."...... ]]

  rm -f "$PKG"
  rm -rf "$BASE"
  rm -rf /tmp/lintpkg_test
}

@test "checks have working directory specified with --extractdir" {
  BASE=$(create_tmp_dir)

  ! [ -z "$BASE" ]

  create_empty_package $BASE
  PKG=$(create_slackware_package $BASE empty 1.0 noarch 1)

  mkdir -p /tmp/lintpkg_test

  run lintpkg -C "$TEST_CHECKS/pkg_variables" -c pkg_working_dir_check --extractdir "/tmp/lintpkg_test" "$PKG"

  [[ "${lines[0]}" =~ "/tmp/lintpkg_test/lintpkg."...... ]]

  rm -f "$PKG"
  rm -rf "$BASE"
  rm -rf /tmp/lintpkg_test
}
