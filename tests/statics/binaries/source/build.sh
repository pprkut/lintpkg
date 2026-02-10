#!/bin/bash
# SPDX-FileCopyrightText: Copyright 2022  Heinz Wiesinger, Amsterdam, The Netherlands
# SPDX-License-Identifier: BSD-1-Clause

gcc hello-bin.c -o hello-x86_64-unstripped
gcc -c -fPIC hello-lib.c -o libhello.o
gcc -shared -o libhello-x86_64-unstripped.so libhello.o
ar rcs libhello-x86_64-unstripped.a libhello.o
rm -f libhello.o
