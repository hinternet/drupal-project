#!/bin/sh

## Check if required tools or binaries are installed.
set -- git sed docker docker-compose
for REQ in "$@"; do
  if ! command -v "$REQ" >> reqs-check.log 2>&1
  then
      echo "$REQ could not be found"
      exit 1;
  fi
done
