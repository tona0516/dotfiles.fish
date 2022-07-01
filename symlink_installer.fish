#!/usr/bin/env fish

set TARGET_DIRECTORY symlink/common
set UNAME_TARGET_DIRECTORY symlink/(uname)

set directories (find $TARGET_DIRECTORY $UNAME_TARGET_DIRECTORY -type d | sed -E "s@^($TARGET_DIRECTORY|$UNAME_TARGET_DIRECTORY)@$HOME@" | sort | uniq | grep -v '^$')
for directory in $directories
    mkdir -p $directory
end

set files (find $TARGET_DIRECTORY $UNAME_TARGET_DIRECTORY -type f)
for file in $files
    set link (echo $file | sed -E "s@^($TARGET_DIRECTORY|$UNAME_TARGET_DIRECTORY)@$HOME@")
    ln -sfnv $PWD/$file $link
end
