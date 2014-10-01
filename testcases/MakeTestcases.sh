#!/bin/sh

# Make test cases for lintpkg

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
TMP=${TMP:-/tmp/SBo}
PKG=$TMP/package-$PRGNAM
OUTPUT=${OUTPUT:-/tmp}

set -e

# Remove any existing testcase packages:
rm -f ${OUTPUT}/$PRGNAM-*.t?z

# Build special cases first:

# ownership-bad: git can't track ownership, so we need a tarball
( PKGNAM=${PRGNAM}-ownership-bad
  rm -rf /tmp/package-$PKGNAM
  mkdir -p /tmp/package-$PKGNAM
  cd /tmp/package-$PKGNAM
  tar xf $CWD/ownership-bad/_ownership-bad.tar.gz
  /sbin/makepkg -l n -c n $OUTPUT/$PKGNAM-$VERSION-$ARCH-$BUILD$TAG.${PKGTYPE:-tgz}
)

# Now build all the others:
for CASEDIR in $(ls -d $CWD/*-bad $CWD/*-good); do
  CASENAM=$(basename ${CASEDIR})
  PKGNAM=${PRGNAM}-${CASENAM}
  if [ ! -e ${OUTPUT}/$PKGNAM-$VERSION-$ARCH-$BUILD$TAG.* ]; then
    ( cd ${CASENAM}
      /sbin/makepkg -l n -c n $OUTPUT/$PKGNAM-$VERSION-$ARCH-$BUILD$TAG.${PKGTYPE:-tgz}
    )
  fi
done

# Finished!
