#!/usr/bin/env sh

ret=0

[ -f "$HOME/.dotrc" ] && source $HOME/.dotrc

# 1. Verify dotfiles directory doesn't exist
dot="$DOTFILES"
[ ! "$dot" ] && dot="$HOME/.dotfiles"

if [ -d "$dot" ]; then
    echo "Error: dotfile directory exists."
    exit 1
fi


# 2. Verify mkdir command
mkdir="${MKDIR}"

if [ -z "$mkdir" ]; then
  mkdir=`which mkdir 2>&1`
  ret=$?
fi

if [ $? -gt 0 ]; then
    echo "Error: Missing mkdir command"
    exit 1
fi


# 3. Verify curl command
curl="${CURL}"

if [ -z "$curl" ]; then
  curl=`which curl 2>&1`
  ret=$?
fi

if [ $? -gt 0 ]; then
    echo "Error: Missing curl command"
    exit 1
fi


# 4. Verify curl command
curl="${CURL}"

if [ -z "$curl" ]; then
  curl=`which curl 2>&1`
  ret=$?
fi

if [ $? -gt 0 ]; then
    echo "Error: Missing curl command"
    exit 1
fi


# 5. Verify make command
make="${MAKE}"

if [ -z "$make" ]; then
  make=`which make 2>&1`
  ret=$?
fi

if [ $? -gt 0 ]; then
    echo "Error: Missing make command"
    exit 1
fi


# 6. Download dotfiles

echo "Downloading..."

if [ `which git 2>&1` ]; then
    git clone https://github.com/collinwat/dotfiles.git $dot 1> /dev/null 2> /dev/null
else
    $mkdir -p "$dot" && \
        $curl -Ls https://github.com/collinwat/dotfiles/tarball/master | \
        $tar -C "$dot" --strip=1 -xzf -
fi

cd "$dot" && $make install
