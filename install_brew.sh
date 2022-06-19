#!/usr/bin/env bash

if command -v brew > /dev/null 2>&1; then
   echo "[dotfiles.fish] brew is already installed."
   exit 0
fi

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
