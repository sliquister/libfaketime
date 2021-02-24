#!/bin/sh

FTPL="${FAKETIME_TESTLIB:-../src/libfaketime.so.1}"

set -e
run1=$(LD_PRELOAD="$FTPL" sh -c 'echo $$')
run2=$(LD_PRELOAD="$FTPL" sh -c 'echo $$')

if [ $run1 = $run2 ]; then
   printf >&2 'got the same pid twice in a row without setting FAKETIME_FAKEPID\n'
   exit 1
fi

output=$(FAKETIME_FAKEPID=13 LD_PRELOAD="$FTPL" sh -c 'echo $$')

if [ $output != 13 ]; then
    printf >&2 'Failed to enforce a rigid response to getpid()\n'
    exit 2
fi
