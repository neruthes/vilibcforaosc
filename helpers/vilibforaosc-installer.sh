#!/bin/bash

echo "Welcome to the portable installer of the portable VI Lib for AOSC.

This installer will:
  - Find the location of itself in the filesystem.
  - Update the local repository it is located in.
  - Re-install the local repository to your '~/.local/share/vilibforaosc'.
  - Install a copy of the lib in the current directory at '_dist/vilibforaosc'.
"



function startjob() {
    WORKDIR="$PWD"
    ### When am I?
    selfpath="$(realpath "$0")"
    gitrepo="$(dirname "$(dirname "$selfpath")")"
    echo "gitrepo=$gitrepo"
    [[ -e "$gitrepo/.env" ]] && source "$gitrepo/.env"
    [[ -e "$gitrepo/.localenv" ]] && source "$gitrepo/.localenv"
    cd "$gitrepo" || exit 1
    ### Update '~/.local/share/vilibforaosc'
    if [[ "$NOAUTOPULL" != y ]]; then
        bash make.sh update && bash make.sh deps/LOGO
    fi
    bash make.sh ins
    rsync -av --delete --mkpath "$HOME/.local/share/vilibforaosc/" "_dist/vilibforaosc/"
}




if [[ $1 == y ]]; then
    startjob
else
    echo "Feeling good? Run the following command to start:
    vilibforaosc-installer.sh y"
fi
