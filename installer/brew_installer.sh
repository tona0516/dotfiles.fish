#!/usr/bin/env bash

shopt -s expand_aliases

DARWIN_BREW_PATH="/opt/homebrew/bin/brew"
LINUX_BREW_PATH="/home/linuxbrew/.linuxbrew/bin/brew"

function is_command_exists() {
    command -v $1 > /dev/null 2>&1; return $?
}

if is_command_exists brew; then
    :
elif is_command_exists $DARWIN_BREW_PATH; then
    alias brew=$DARWIN_BREW_PATH
elif is_command_exists $LINUX_BREW_PATH; then
    alias brew=$LINUX_BREW_PATH
else
    exit 1
fi

brew bundle --file homebrew/Brewfile.minimum