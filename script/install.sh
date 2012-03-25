#!/usr/bin/env sh

[ -f "$HOME/.dotrc" ] && source $HOME/.dotrc


# 1. Verify dotfiles directory doesn't exist

dot="$DOTFILES"
[ ! "$dot" ] && dot="$HOME/.dotfiles"
[ -d "$dot" ] && echo "Error: dotfile directory exists." && exit 1


# 2. Location required commands

mkdir="${MKDIR}"
[ -z "$mkdir" ] && mkdir=`which mkdir 2> /dev/null`
[ -z "$mkdir" ] && echo "Error: Missing mkdir command" && exit 1

make="${MAKE}"
[ -z "$make" ] && make=`which make 2> /dev/null`
[ -z "$make" ] && echo "Error: Missing make command" && exit 1

curl="${CURL}"
[ -z "$curl" ] && curl=`which curl 2> /dev/null`
[ -z "$curl" ] && echo "Error: Missing curl command" && exit 1

git="${GIT}"
[ -z "$git" ] && git=`which git 2> /dev/null`


# 3. Get

echo "Downloading..."

if [ -z "$git" ]; then
    $mkdir -p "$dot" && \
        $curl -Ls https://github.com/collinwat/dotfiles/tarball/master | \
        $tar -C "$dot" --strip=1 -xzf -
else
    git clone https://github.com/collinwat/dotfiles.git $dot 1> /dev/null 2> /dev/null
fi


# 4. Install

cd "$dot" && $make install
