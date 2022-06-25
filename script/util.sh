#!/usr/bin/env bash

DOTFILES_NAME="dotfiles.fish"

function is_command_exists() {
    command -v $1 > /dev/null 2>&1; return $?
}

function is_file_exists() {
    [[ -f "$1" ]] && return 0 || return 1
}

function is_directory_exists() {
    [[ -d "$1" ]] && return 0 || return 1
}

function log_info() {
    printf "\033[32m[$DOTFILES_NAME] %s\033[m\n" "$@"
}

function log_warn() {
    printf "\033[33m[$DOTFILES_NAME] %s\033[m\n" "$@"
}

function log_error() {
    printf "\033[31m[$DOTFILES_NAME] %s\033[m\n" "$@"
}