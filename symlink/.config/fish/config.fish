alias executable='type $argv[1] > /dev/null 2>&1'

set -x LSCOLORS "gxfxcxdxbxegedabagacag" # for Darwin
set -x LS_COLORS "di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30" # For Linux

if status is-interactive
    alias is_macos="test (uname -s) = 'Darwin'"
    alias refresh='exec fish -l'
    is_macos && alias ls='ls -G -F' || alias ls='ls --color=auto -F'
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
    executable nvim && alias vi='nvim'
    executable nvim && alias vim='nvim'
    executable docker && alias d="docker"
    executable kubectl && alias k="kubectl"

    set -x FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'

    bind \cd delete-char
    bind \cd 'enhancd; commandline -f repaint'

    fish_add_path /opt/homebrew/bin
    fish_add_path $HOME/Library/Android/sdk/platform-tools
    fish_add_path $HOME/Library/Android/sdk/emulator

    set DARWIN_BREW /opt/homebrew/bin/brew
    if executable $DARWIN_BREW; eval ($DARWIN_BREW shellenv); end

    set LINUX_BREW /home/linuxbrew/.linuxbrew/bin/brew
    if executable $LINUX_BREW; eval ($LINUX_BREW shellenv); end

    set MISE ~/.local/bin/mise
    if executable $MISE; $MISE activate fish | source; end
end
