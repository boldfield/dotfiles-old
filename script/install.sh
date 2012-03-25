#!/usr/bin/env bash

ret=0

# 1. Verify dotfiles directory doesn't exist
dot="$DOTFILES"
[ ! "$dot" ] && dot="$HOME/.dotfiles"
dot="$HOME/.dotfiles"

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


# 4. Verify tar command
tar="${TAR}"

if [ -z "$tar" ]; then
  tar=`which tar 2>&1`
  ret=$?
fi

if [ $? -gt 0 ]; then
    echo "Error: Missing tar command"
    exit 1
fi


# 5. Download dotfiles

mkdir -p "$dot" && \
    curl -L https://github.com/collinwat/dotfiles/tarball/master | \
    tar -C "$dot" --strip=1 -xzf -

cd "$dot" && make install
