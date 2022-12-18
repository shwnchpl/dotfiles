##########################################
# config.fish - Custom Fish configuration.
##########################################

# If ~/.bash_env exists, load it. It should be directly compatible with
# Fish versions 3.1 and newer.
if test -e ~/.bash_env
    function prepend_path
        mkdir -p $argv[1] 2> /dev/null
        fish_add_path -pP $argv[1]
    end
    . ~/.bash_env
    functions -e prepend_path
end

# If ~/.bash_aliases exists, load it. Like ~/.bash_env, it should be
# directly compatible with Fish versions 3.1 and newer.
if test -e ~/.bash_aliases
    . ~/.bash_aliases
end

# If ~/.config/fish/local-env.fish exists, source it. It is a system
# specific file that may contain additional configuration or adjustments
# for compatibility purposes.
if test -e ~/.config/fish/local-env.fish
    . ~/.config/fish/local-env.fish
end

# If ~/.opam/opam-init/init.fish exists, source it.
if test -e ~/.opam/opam-init/init.fish
    . ~/.opam/opam-init/init.fish
end

if status is-interactive
    # Set up custom key bindings.
    fish_vi_key_bindings

    if type -q fzf
        fzf_key_bindings
    end

    bind -M insert \cn accept-autosuggestion

    # Set fish specific environment variables.
    set -gx fish_greeting
    set -gx fish_color_at           brgreen
    set -gx fish_color_cwd          blue
    set -gx fish_color_host         brgreen
    set -gx fish_color_host_remote  yellow

    # Disable vim mode indicator
    function fish_mode_prompt
        # no-op
    end
end
