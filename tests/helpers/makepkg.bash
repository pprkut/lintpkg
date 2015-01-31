
create_tmp_dir() {
  echo $(mktemp -d -t lintpkg_test.XXXXXX)
  return 0
}

create_empty_package() {
  BASE="$1"

  if [ -z "$BASE" ]; then
    return 1
  fi

  mkdir -p $BASE/install $BASE/usr/bin
  cp $TEST_STATICS/slack-desc $BASE/install/
  touch $BASE/usr/bin/foo

  chmod +x $BASE/usr/bin/foo

  return 0
}

create_slackware_package() {
  BASE="$1"
  NAME="$2"
  VERSION="$3"
  ARCH="$4"
  BUILD="$5"

  if [ -z "$BASE" -o -z "$NAME" -o -z "$VERSION" -o -z "$ARCH" -o -z "$BUILD" ]; then
    return 1
  fi

  sed -i "s|LINTPKG_TEST|$NAME|g" $BASE/install/slack-desc

  cd $BASE
    /sbin/makepkg -l y -c n "/tmp/$NAME-$VERSION-$ARCH-$BUILD.tgz" > /dev/null
  cd - > /dev/null

  echo "/tmp/$NAME-$VERSION-$ARCH-$BUILD.tgz"
  return 0
}

create_tar_listing() {
  BASE="$1"
  NEW="$2"

  cd $BASE
    while read line && ! [ -z "$line" ]; do

      if [ -z "$NEW" -a "$(echo $line | wc -L)" -gt 2 ]; then
        line=$(echo "$line" | sed 's|./||')
      fi

      if ! [ -z "$NEW" ] && [ "$line" = "./" ]; then
        continue
      fi

      echo "$line"
    done <<< "$(find . -exec ls -dp {} \;)"

  cd - &> /dev/null
  return 0
}

create_detailed_tar_listing() {
  BASE="$1"
  NEW="$2"

  cd $BASE
    while read line && ! [ -z "$line" ]; do
      TYPE=$(echo $line | head -c 1)
      PERMS=$(echo $line | cut -d " " -f 1)
      OWNER=$(echo $line | cut -d " " -f 3)
      GROUP=$(echo $line | cut -d " " -f 4)
      DATE=$(echo $line | cut -d " " -f 6)
      TIME=$(echo $line | cut -d " " -f 7)
      FILE=$(echo $line | cut -d " " -f 8-)

      if [ -z "$NEW" -a "$(echo $FILE | wc -L)" -gt 2 ]; then
        FILE=$(echo "$FILE" | sed 's|./||')
      fi

      if ! [ -z "$NEW" ] && [ "$FILE" = "./" ]; then
        continue
      fi

      if [ "$TYPE" = "d" -o "$TYPE" = "l" ]; then
        SIZE=0
      else
        SIZE=$(echo $line | cut -d " " -f 5)
      fi

      echo "$PERMS $OWNER/$GROUP $SIZE $DATE $TIME $FILE"
    done <<< "$(find . -exec ls -dlp --time-style=long-iso {} \;)"

  cd - &> /dev/null
  return 0
}

