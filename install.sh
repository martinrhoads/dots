#!/bin/bash -ex

# paths
dirname=$( cd $(dirname $0) && echo $(pwd) )
lib="/usr/local/lib"
bin="/usr/local/bin"

# make in case they aren't already there
sudo mkdir -p $lib $bin

# Copy the path
rm -rf $lib/dots && cp -R $dirname "$lib/"

# symlink dots
ln -sf "$lib/dots/dots.sh" "$bin/dots"

# Ubuntu-only: Change from dash to bash
if [ "$BASH_VERSION" = '' ]; then
  sudo echo "dash    dash/sh boolean false" | debconf-set-selections ; dpkg-reconfigure --frontend=noninteractive dash
fi

echo done installing dots
