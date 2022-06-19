#!/usr/bin/env bash

mkdir -p ~/.config/fish/
mkdir -p ~/.config/pet/
ln -sfnv $PWD/fish/config.fish ~/.config/fish/config.fish
ln -sfnv $PWD/fish/fish_plugins ~/.config/fish/fish_plugins
ln -sfnv $PWD/pet/config.toml ~/.config/pet/config.toml
ln -sfnv $PWD/pet/snippet.toml ~/.config/pet/snippet.toml
ln -sfnv $PWD/.vimrc ~/.vimrc