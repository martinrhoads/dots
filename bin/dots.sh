#!/usr/bin/env bash
version="0.0.7"

# dots(1) main
main() {

  # paths
  export dotsdir=$(dirname $(cd $(dirname $0) && echo $(pwd) ))
  export lib="$dotsdir/lib"
  export os="$dotsdir/os"

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
    reload )
      source "$HOME/.bash_profile"
      ;;
    boot )
      boot $2
      exit
      ;;
    update )
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

    reload                  Reload the dotfiles
    boot <os>               Bootstrap the given operating system
    update <os|dots>        Update the os or dots

EOF
}

# Bootstrap the OS
boot() {
  if [[ -e "$os/$1/index.sh" ]]; then
    sh "$os/$1/index.sh"
  else
    echo "boot: could not find \"$1\""
    exit 1
  fi
}

# update either dots or OS
update() {
  if [[ -e "$os/$1/index.sh" ]]; then
    sh "$os/$1/update.sh"
  else
    updatedots
  fi
}

# update dots(1) via git clone
updatedots() {
  echo "updating dots..."

  if ! test -d /usr/local/lib/dots/.git; then
      echo checking out dots repo...
      git clone --bare https://github.com/martinrhoads/dots /usr/local/lib/dots/.git
      git config core.bare false
  fi

  (
    cd /usr/local/lib/dots
    git pull
  )

  echo "updated dots to $(dots --version)."
  exit
}


# Call main
main "$@"
