#!/bin/bash 

#!/usr/bin/env bash
version="0.0.7"

set -o nounset
set -e

# dots(1) main
main() {

  # paths
    echo \$0 is $0
    echo readlink is $(readlink $0)
    echo bash source is "${BASH_SOURCE[0]}"
  export dotsdir=$(dirname $(cd $(dirname $( readlink $0) ) && echo $(pwd) ))
  echo dotsdir is $dotsdir
  exit 1
  export lib="$dotsdir/lib"
  export os="$dotsdir/os"

  arg1=${1:-}
  if [ -z ${arg1} ]; then
    usage
    exit
  fi

  # parse options
  while [[ "$1" =~ ^- ]]; do
    case $1 in
      -v | --version )
        echo $version
        exit
        ;;
      -h | --help )
        usage
        exit
        ;;
    esac
    shift
  done

  # run command
  case $1 in
    configure )
      configure
      exit
      ;;
    update )
      arg2=${2:-}
      if test -z "$arg2"; then
        usage 
        exit
      fi
      update $2
      exit
      ;;
    *)
      usage
      exit
      ;;
  esac
}

# usage info
usage() {
  cat <<EOF

  Usage: dots [options] [command] [args ...]

  Options:

    -v, --version           Get the version
    -h, --help              This message

  Commands:

    configure               Configure operating system
    update <os|dots>        Update the os or dots

EOF
}

# Bootstrap the OS
configure() {
  echo configuring system
  # set -x
  . $os/`detect_os`/index.sh
  echo done configuring system\!
}


# update either dots or OS
update() {
  case $1 in
    os )
      . $os/`detect_os`/update.sh
    ;;
    dots )
      updatedots
      ;;
    *)
      usage
      exit
      ;;
  esac



}

# update dots(1) via git clone
updatedots() {
  echo "updating dots..."

  if ! test -d /usr/local/lib/dots/.git; then
    (
      cd /usr/local/lib/dots
      echo checking out dots repo...
      git clone --bare https://github.com/martinrhoads/dots .git
      git config core.bare false
      git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
      git add .
      git checkout testing
      git config branch.testing.remote origin
      git config branch.testing.merge refs/heads/testing
    )
  fi

  (
    cd /usr/local/lib/dots
    git pull
  )

  echo "updated dots to $(dots --version)."
  exit
}


detect_os() {
  if test `uname` == Darwin; then
    platform=osx
  elif test `lsb_release -is` == Ubuntu; then
    platform=ubuntu
  fi
  
  if ! test $platform; then
    echo could not detect platform
    exit 1
  fi

  echo $platform
}


# Call main
main "$@"
