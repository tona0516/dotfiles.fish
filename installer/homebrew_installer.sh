#!/usr/bin/env bash
source script/util.sh

if is_command_exists brew; then
    info "brew is already installed."
    exit 0
fi

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
