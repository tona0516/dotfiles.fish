set -x LSCOLORS gxfxcxdxbxegedabagacag # for Darwin
set -x LS_COLORS "di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30" # For Linux

if status is-interactive
    alias is_macos="test (uname -s) = 'Darwin'"
    alias refresh='exec fish -l'
    if is_macos
        alias ls='ls -G -F'
    else
        alias ls='ls --color=auto -F'
    end
    alias ll='ls -lh'
    alias lla='ls -lha'
    alias sl='ls'
    alias h='hostname'
    alias g='git'
    alias gb='git branch'
    alias gs='git status'
    alias gl="git log --pretty='format:%C(yellow)%h %C(cyan)%an %C(green)%cd %C(reset)%s %C(red)%d' --date=short"
    alias gll='git-forgit log'
    alias gd='git diff'
    alias gdd='git diff --cached'
    alias ssh='ssh -A'
    alias ..='cd ..'
    alias svim='sudo -E vim'
    alias df='df -h'
    type -q docker; and alias d docker
    type -q kubectl; and alias k kubectl

    set -x FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'
    set -x ENHANCD_ENABLE_DOUBLE_DOT false

    bind \cd delete-char
    bind \cd 'enhancd; commandline -f repaint'

    fish_add_path /opt/homebrew/bin
    fish_add_path $HOME/Library/Android/sdk/platform-tools
    fish_add_path $HOME/Library/Android/sdk/emulator

    set DARWIN_BREW /opt/homebrew/bin/brew
    if test -x "$DARWIN_BREW"
        eval ($DARWIN_BREW shellenv)
    end

    set LINUX_BREW /home/linuxbrew/.linuxbrew/bin/brew
    if test -x "$LINUX_BREW"
        eval ($LINUX_BREW shellenv)
    end

    set MISE ~/.local/bin/mise
    if test -x "$MISE"
        $MISE activate fish | source
    end
end

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/tona0516/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
