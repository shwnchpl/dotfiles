#####################################
# System specific fish configuration.
#####################################

if status is-interactive
    if type -q fzf
        # XXX: Attempt to source fzf fish key bindings. This is
        # necessary on some systems, including this one.
        if test -e /usr/share/fzf/key-bindings.fish
            . /usr/share/fzf/key-bindings.fish
        end
    end
end
