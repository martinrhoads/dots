#set -x 

casks=(
  alfred
  dropbox
  google-chrome
  flash
  iterm2
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

tap_installed() {
  if ! test $INSTALLED_TAPS; then
    INSTALLED_TAPS=`brew tap`
  fi
  echo $INSTALLED_TAPS | grep -q "$1"
}

cask_installed() {
  if ! test $INSTALLED_CASKS; then
    INSTALLED_CASKS=`brew cask list`
  fi
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


  for font in ${font[@]}; do
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


echo installing casks..
main "$@"
echo done installing casks\!
