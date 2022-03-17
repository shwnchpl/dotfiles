# Set general environment variables.
set -gx EDITOR                  vim
set -gx NNN_USE_EDITOR          1
set -gx NNN_RESTRICT_NAV_OPEN   1
set -gx PATH                    "$HOME/bin:/sbin:$PATH"

# Load bash aliases. This file should be compatible.
if test -e ~/.bash_aliases
    . ~/.bash_aliases
end

if status is-interactive
    fish_vi_key_bindings

    # Set fish specific environment variables.
    set -gx fish_color_at           green
    set -gx fish_color_cwd          blue
    set -gx fish_color_host         green
    set -gx fish_color_host_remote  yellow

    if test -e ~/.bash_ssh
        bash ~/.bash_ssh
    end

    function fish_mode_prompt
        # NOOP - Disable vim mode indicator
    end
end
