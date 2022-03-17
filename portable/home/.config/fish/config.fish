if status is-interactive
    fish_vi_key_bindings

    set -gx EDITOR vim
    set -gx NNN_USE_EDITOR 1
    set -gx NNN_RESTRICT_NAV_OPEN 1

    if test -e ~/.bash_ssh
        bash ~/.bash_ssh
    end

    function vimallwith -d "Open all files containing some pattern in Vim"
        grep --color=none -rIl $argv . |
            xargs bash -c '</dev/tty vim "$@"' ignoreme
    end
end

set -gx PATH "$HOME/bin:/sbin:$PATH"

# Load bash aliases. This file should be compatible.
if test -e ~/.bash_aliases
    . ~/.bash_aliases
end
