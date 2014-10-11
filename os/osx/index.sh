# modules
source "$lib/symlink/index.sh"
source "$lib/is-osx/index.sh"

osx="$os/osx"

# Run each program
. $osx/defaults.sh
. $osx/binaries.sh
. $osx/apps.sh
