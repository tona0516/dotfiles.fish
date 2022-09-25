function vim-modified
    set git_repository_root (git rev-parse --show-toplevel)
    if not string length -q -- $git_repository_root
        return
    end

    set changed_files (git status --porcelain)
    if not string length -q -- $changed_files
        return
    end

    set selected_file (echo $changed_files | awk '{print $2}' | fzf +m)
    if not string length -q -- $selected_file
        return
    end

    vim $git_repository_root/$selected_file
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr g "git"
    abbr gs "git status"
    abbr gb "git branch"
    abbr gd "git diff"
    abbr gdd "git diff --cached"
    abbr gl "git log --pretty='format:%C(yellow)%h %C(cyan)%an %C(green)%cd %C(reset)%s %C(red)%d' --date=short"
    abbr gll "glo"
    abbr sl "ls"
    abbr ll "ls -l"
    abbr lla "ls -la"
    abbr d "docker"
    abbr k "kubectl"
    abbr ssh "ssh -A"
    abbr relogin "exec fish -l"
    abbr vim-sudo "sudo -E vim"

    set -x FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border"

    set -x ENHANCD_DISABLE_HOME 0
    set -x ENHANCD_DISABLE_DOT 1
    set -x ENHANCD_DISABLE_HYPHEN 1
    set -x ENHANCD_FILTER fzf

    set -x LSCOLORS "gxfxcxdxbxegedabagacag" # for Darwin
    set -x LS_COLORS "di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30" # For Linux

    if command -v /opt/homebrew/bin/brew > /dev/null 2>&1; eval (/opt/homebrew/bin/brew shellenv); end
    if command -v /home/linuxbrew/.linuxbrew/bin/brew > /dev/null 2>&1; eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv); end
    fish_add_path $HOME/Library/Android/sdk/platform-tools
    fish_add_path $HOME/Library/Android/sdk/emulator
    fish_add_path /opt/homebrew/opt/openjdk@11/bin

    fish_config theme choose "Base16 Default Dark"
end
