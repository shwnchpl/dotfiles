# Set general environment variables.
set -gx EDITOR                  vim
set -gx NNN_USE_EDITOR          1
set -gx NNN_RESTRICT_NAV_OPEN   1
set -gx PATH                    "$HOME/bin:/sbin:$PATH"

# Highlight inside manpages.
set -gx MANPAGER                'less -R --use-color -Dd+r -Du+b'

# Load bash aliases. This file should be compatible.
if test -e ~/.bash_aliases
    . ~/.bash_aliases
end

if status is-interactive
    fish_vi_key_bindings

    if type -q fzf
        fzf_key_bindings
    end

    # Set fish specific environment variables.
    set -gx fish_greeting
    set -gx fish_color_at           brgreen
    set -gx fish_color_cwd          blue
    set -gx fish_color_host         brgreen
    set -gx fish_color_host_remote  yellow

    function fish_mode_prompt
        # NOOP - Disable vim mode indicator
    end
end
