#!/bin/sh -e

echo " # The legacy build support script"
echo " # -------------------------------"

set --
if [ -e build.sh ]; then
  echo " ### Detected 'build.sh' executing it with bash. ###"
  set -- /bin/bash build.sh
elif [ -e Makefile ] && grep -qsE '^SPHINXBUILD' Makefile && grep -qsE '^html:' Makefile; then
  echo " ### Detected sphinx Makefile. Running 'make html'. Add nop 'build.sh' to disable this! ###"
  set -- html
  if grep -qsE '^touchrst:' Makefile; then
      set -- touchrst "$@"
  fi
  set -- make "$@"
else
  echo " ### No build.sh or sphinx Makefile. Not building the course. ###"
fi

if [ "$1" ]; then
  echo " # Executing: $@"
  exec "$@"
fi
exit 0
