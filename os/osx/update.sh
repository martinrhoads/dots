# kill on error
set -e


# update brew packages
echo updateing brew...
brew update
brew upgrade


# cleanup
echo running brew cleanup...
brew cleanup

echo done
