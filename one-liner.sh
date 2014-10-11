# to install:
# curl https://raw.githubusercontent.com/martinrhoads/dots/testing/one-liner.sh | bash 

if test -d /usr/local/lib/dots; then
  echo /usr/local/lib/dots already exists. 
  echo remove /usr/local/lib/dots if you would like to proceede.
  echo exiting...
  exit 1
fi


if ! test -d /usr/local; then
  sudo mkdir /usr/local 
  sudo chmod -R 757 /usr/local
fi

mkdir -p /usr/local/lib/dots /usr/local/bin


mkdir -p /usr/local/lib/dots
cd /usr/local/lib/dots
curl -L https://github.com/matthewmueller/dots/archive/master.tar.gz | tar zx --strip 1

ln -s /usr/local/lib/dots /usr/local/bin/dots
