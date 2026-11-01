#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2014  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

create_empty_package() {
  BASE="$1"

  if [ -z "$BASE" ]; then
    return 1
  fi

  mkdir -p "$BASE/install" "$BASE/usr/bin"
  cp "$TEST_STATICS/slack-desc" "$BASE/install/"
  touch "$BASE/usr/bin/foo"

  chmod +x "$BASE/usr/bin/foo"

  return 0
}

create_slackware_package() {
  BASE="$1"
  NAME="$2"
  VERSION="$3"
  ARCH="$4"
  BUILD="$5"
  EXTENSION="${6:-tgz}"

  if [ -z "$BASE" -o -z "$NAME" -o -z "$VERSION" -o -z "$ARCH" -o -z "$BUILD" ]; then
    return 1
  fi

  sed -i "s|LINTPKG_TEST|$NAME|g" "$BASE/install/slack-desc"

  (
    cd "$BASE" || exit 1
    # MAKEPKG_OPTIONS can contain multiple options:
    # shellcheck disable=SC2086
    /sbin/makepkg -l y -c n $MAKEPKG_OPTIONS "/tmp/$NAME-$VERSION-$ARCH-$BUILD.$EXTENSION" > /dev/null
  ) || return 1

  echo "/tmp/$NAME-$VERSION-$ARCH-$BUILD.$EXTENSION"
  return 0
}

create_tar_listing() {
  BASE="$1"
  NEW="$2"

  (
    cd "$BASE" || exit 1

    while IFS= read -r line && ! [ -z "$line" ]; do

      if [ -z "$NEW" -a "$(echo "$line" | wc -L)" -gt 2 ]; then
        line=$(echo "$line" | sed 's|./||')
      fi

      if ! [ -z "$NEW" ] && [ "$line" = "./" ]; then
        continue
      fi

      echo "$line"
    done <<< "$(find . -exec ls -dp {} \;)"
  ) || return 1
  return 0
}

create_detailed_tar_listing() {
  BASE="$1"
  NEW="$2"

  (
    cd "$BASE" || exit 1

    while read -r PERMS _ OWNER GROUP SIZE DATE TIME FILE && ! [ -z "$PERMS" ]; do
      TYPE=${PERMS:0:1}

      if [ -z "$NEW" -a "$(echo "$FILE" | wc -L)" -gt 2 ]; then
        FILE=$(echo "$FILE" | sed 's|./||')
      fi

      if ! [ -z "$NEW" ] && [ "$FILE" = "./" ]; then
        continue
      fi

      if [ "$TYPE" = "d" -o "$TYPE" = "l" ]; then
        SIZE=0
      fi

      echo "$PERMS $OWNER/$GROUP $SIZE $DATE $TIME $FILE"
    done <<< "$(find . -exec ls -dlp --time-style=long-iso {} \;)"
  ) || return 1
  return 0
}
