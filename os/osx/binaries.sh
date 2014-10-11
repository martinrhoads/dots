# Check for Homebrew install
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


INSTALLED_PACKAGES=`brew list`

package_installed() {
  echo $INSTALLED_PACKAGES | grep -q "$1"
}



packages=(
  brew-cask
  coreutils
  findutils
  bash
  emacs
  tmux
  zsh
  git
  boot2docker
)


for package in "${packages[@]}"; do
  if ! `package_installed $package`; then
    echo installing $package
    brew install $package
  fi
done


