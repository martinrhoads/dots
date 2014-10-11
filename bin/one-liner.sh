# to install:
# curl https://raw.githubusercontent.com/martinrhoads/dots/testing/one-liner.sh | bash 

set -x
set -e

if test -d /usr/local/lib/dots; then
  echo /usr/local/lib/dots already exists. 
  echo remove /usr/local/lib/dots if you would like to proceede.
  echo exiting...
  exit 1
fi

sudo -v


if ! test -d /usr/local; then
  sudo mkdir /usr/local 
  sudo chmod -R 757 /usr/local
fi

mkdir -p /usr/local/lib/dots /usr/local/bin


mkdir -p /usr/local/lib/dots
cd /usr/local/lib/dots
curl -L https://github.com/martinrhoads/dots/archive/testing.tar.gz | tar zx --strip 1

ln -sf /usr/local/lib/dots/bin/dots.sh /usr/local/bin/dots


