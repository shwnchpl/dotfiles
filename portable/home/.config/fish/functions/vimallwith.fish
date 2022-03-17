function vimallwith -d "Open all files containing some pattern in Vim"
    grep --color=none -rIl $argv . |
    xargs bash -c '</dev/tty vim "$@"' ignoreme
end
