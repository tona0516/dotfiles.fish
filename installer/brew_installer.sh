#!/usr/bin/env bash
source script/util.sh

shopt -s expand_aliases

BREWFILE="Brewfile"
DARWIN_BREW_PATH="/opt/homebrew/bin/brew"
LINUX_BREW_PATH="/home/linuxbrew/.linuxbrew/bin/brew"

if is_command_exists brew; then
    :
elif is_command_exists $DARWIN_BREW_PATH; then
    alias brew=$DARWIN_BREW_PATH
elif is_command_exists $LINUX_BREW_PATH; then
    alias brew=$LINUX_BREW_PATH
else
    log_error "Homebrew is not installed."
    exit 1
fi

brew bundle --file $BREWFILE