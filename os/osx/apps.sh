#set -x 

casks=(
  alfred
  dropbox
  google-chrome
  google-drive
  flash
  iterm2
  lastpass-universal
  radiant-player
  vagrant
  virtualbox
  vlc
)

fonts=(
  font-m-plus
  font-clear-sans
  font-roboto
)

taps=(
  caskroom/cask
  caskroom/fonts
  caskroom/versions
  homebrew/dupes
)

INSTALLED_TAPS=`brew tap`

tap_installed() {
  echo $INSTALLED_TAPS | grep -q "$1"
}


if ! `brew cask > /dev/null 2>&1`; then
  echo installing brew-cask
  brew install caskroom/cask/brew-cask
fi


INSTALLED_CASKS=`brew cask list`

cask_installed() {
  echo $INSTALLED_CASKS | grep -q "$1"
}

# Specify the location of the apps
appdir="/Applications"


main() {

  # Ensure homebrew is installed
  homebrew


  for tap in ${taps[@]}; do
    if ! `tap_installed $tap`; then
      echo installing tap $tap
      brew tap $tap
    fi
  done

  for cask in ${casks[@]}; do
    if ! `cask_installed $cask`; then
      echo installing cask $cask
      brew cask install --appdir=$appdir $cask
    fi
  done


  for font in ${fonts[@]}; do
    if ! `cask_installed $font`; then
      echo installing font $font
      brew cask install $font
    fi
  done


}

homebrew() {
  if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}


main "$@"
