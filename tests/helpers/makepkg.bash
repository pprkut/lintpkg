
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



