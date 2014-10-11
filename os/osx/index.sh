#!/usr/bin/env bash -ex

set -e

# modules
source "$lib/symlink/index.sh"
source "$lib/is-osx/index.sh"

# Only run if on a Mac
if [ 0 -eq `osx` ]; then
  exit 0
fi

# exit 1
# paths
osx="$os/osx"

# Run each program
sh "$osx/defaults.sh"
sh "$osx/binaries.sh"
sh "$osx/apps.sh"
