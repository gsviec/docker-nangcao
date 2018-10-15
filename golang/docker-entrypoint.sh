#!/bin/sh
set -eo pipefail
echo "Start service $PROJECT_NAME"

case $1 in
  start)       
    ./app -stderrthreshold=INFO $@
    ;;
  *) 
    exec "$@"
    ;;
esac

