#!/bin/bash

gcc hello-bin.c -o hello-x86_64-unstripped
gcc -c -fPIC hello-lib.c -o libhello.o
gcc -shared -o libhello-x86_64-unstripped.so libhello.o
rm -f libhello.o
