
package_installed() {
  if ! test $INSTALLED_PACKAGES; then
    INSTALLED_PACKAGES=`brew list`
  fi 
  echo $INSTALLED_PACKAGES | grep -q "$1"
}

# Check for Homebrew install
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi



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
  zsh
)

echo installing homebrew packages

for package in "${packages[@]}"; do
  if ! `package_installed $package`; then
    echo installing $package
    brew install $package
  fi
done


echo done installing homebrew packages
