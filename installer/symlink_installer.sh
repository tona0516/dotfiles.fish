#!/usr/bin/env bash
source script/util.sh

TARGET_DIRECTORY="symlink/common"
UNAME_TARGET_DIRECTORY="symlink/$(uname)"

directories=$(find $TARGET_DIRECTORY $UNAME_TARGET_DIRECTORY -type d | sed -E "s@^($TARGET_DIRECTORY|$UNAME_TARGET_DIRECTORY)@$HOME@" | sort | uniq | grep -v "^$")
for directory in $directories
do
    mkdir -p $directory
done

files=$(find $TARGET_DIRECTORY $UNAME_TARGET_DIRECTORY -type f)
for file in $files
do
    link=$(echo $file | sed -E "s@^($TARGET_DIRECTORY|$UNAME_TARGET_DIRECTORY)@$HOME@")
    ln -sfnv $PWD/$file $link
done