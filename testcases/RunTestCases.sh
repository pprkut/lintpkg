#!/bin/sh

# Make and then run the test cases for lintpkg

# Copyright 2014 David Spencer, Baildon, West Yorkshire, U.K.
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

PRGNAM=lintpkg-testcase
VERSION=${VERSION:-0.0}
BUILD=${BUILD:-1}
TAG=${TAG:-_lintpkg}

if [ -z "$ARCH" ]; then
  case "$( uname -m )" in
    i?86) ARCH=i486 ;;
    arm*) ARCH=arm ;;
       *) ARCH=$( uname -m ) ;;
  esac
fi

CWD=$(pwd)
TMP=${TMP:-/tmp}
PKG=$TMP/package-$PRGNAM
OUTPUT=${OUTPUT:-/tmp}

set -e

# Remove any existing testcase packages:
rm -f ${OUTPUT}/$PRGNAM-*.t?z

echo ""
echo "Creating testcase packages..."

# Build special cases first:

# ownership-bad, permissions-bad:
# git can't track ownership and permissions, so we need to store the payload in a tarball
for CASENAM in ownership-bad permissions-bad ; do
  ( PKGNAM=${PRGNAM}-${CASENAM}
    rm -rf $TMP/package-$PKGNAM
    cp -a $CWD/${CASENAM} $TMP/package-$PKGNAM
    cd $TMP/package-$PKGNAM
    tar xf _${CASENAM}.tar.gz
    rm _${CASENAM}.tar.gz
    /sbin/makepkg -l n -c n $OUTPUT/$PKGNAM-$VERSION-$ARCH-$BUILD$TAG.${PKGTYPE:-tgz} >/dev/null 2>&1
    if [ $? = 0 ]; then
      echo "Slackware package $OUTPUT/$PKGNAM-$VERSION-$ARCH-$BUILD$TAG.${PKGTYPE:-tgz} created."
    else
      echo "Error: Failed to create package for testcase $CASENAM"
    fi
  )
done

# tar113-bad: don't use makepkg :O
( CASENAM=tar113-bad
  PKGNAM=${PRGNAM}-${CASENAM}
  cd $CWD/${CASENAM}
  case ${PKGTYPE:-tgz} in
    'tgz' )  packagecompression=gzip ;;
    'tbz' )  packagecompression=bzip2 ;;
    'tlz' )  packagecompression=lzma ;;
    'txz' )  packagecompression=xz ;;
        * )  packagecompression=cat ;;
  esac
  tar cf - . | $packagecompression > $OUTPUT/$PKGNAM-$VERSION-$ARCH-$BUILD$TAG.${PKGTYPE:-tgz}
  if [ $? = 0 ]; then
    echo "Slackware package $OUTPUT/$PKGNAM-$VERSION-$ARCH-$BUILD$TAG.${PKGTYPE:-tgz} created."
  else
    echo "Error: Failed to create package for testcase $CASENAM"
  fi
)

# Now build all the others:
for CASEDIR in $(ls -d $CWD/*-bad* $CWD/*-good*); do
  CASENAM=$(basename ${CASEDIR})
  PKGNAM=${PRGNAM}-${CASENAM}
  if [ ! -e ${OUTPUT}/$PKGNAM-$VERSION-$ARCH-$BUILD$TAG.* ]; then
    ( cd ${CASENAM}
      /sbin/makepkg -l n -c n $OUTPUT/$PKGNAM-$VERSION-$ARCH-$BUILD$TAG.${PKGTYPE:-tgz} >/dev/null 2>&1
      if [ $? = 0 ]; then
        echo "Slackware package $OUTPUT/$PKGNAM-$VERSION-$ARCH-$BUILD$TAG.${PKGTYPE:-tgz} created."
      else
        echo "Error: Failed to create package for testcase $CASENAM"
      fi
    )
  fi
done

# Now run lintpkg on the built test cases:

echo ""
echo "Running testcases..."

for check in ../checks/*_check.sh; do
  CHKNAM=$(basename $check _check.sh)
  # Put actual and expected output into these files:
  ACTUAL=$OUTPUT/$PRGNAM-$CHKNAM-actual
  EXPECTED=$OUTPUT/$PRGNAM-$CHKNAM-expected
  # There may be zero or more testcases for each check, but usually there will
  # be two: -good and -bad
  for TESTPKG in $(ls $OUTPUT/$PRGNAM-$CHKNAM-*.t?z 2>/dev/null); do
    sh ../lintpkg -c ${CHKNAM}_check $TESTPKG 2>&1 | grep -v ' checked; ' | cut -f 3- -d" " | sort > $ACTUAL
    tar xf $TESTPKG -O --wildcards */doc/lintpkg-*/expected | sort > $EXPECTED
    if cmp -s $ACTUAL $EXPECTED; then
      echo $(basename $TESTPKG) pass
    else
      echo $(basename $TESTPKG) FAIL
    fi
  done
done

# Finished!
