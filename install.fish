#!/usr/bin/env fish

alias executable='type $argv[1] > /dev/null 2>&1'

function create_symlinks
    set TARGET_DIRECTORY symlink
    
    set directories (find $TARGET_DIRECTORY -type d | sed -E "s@^($TARGET_DIRECTORY)@$HOME@" | sort | uniq | grep -v '^$')
    for directory in $directories
        mkdir -p $directory
    end
    
    set files (find $TARGET_DIRECTORY -type f)
    for file in $files
        set link (echo $file | sed -E "s@^$TARGET_DIRECTORY@$HOME@")
        ln -sfnv $PWD/$file $link
    end
end

function install_mise
    curl https://mise.run | sh
    eval "$(~/.local/bin/mise activate fish)"
    mise i
end

function install_fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher update
end

create_symlinks
install_mise
install_fisher