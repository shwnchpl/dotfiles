#########################################################
# .bash_aliases - Aliases for Bash and compatible shells.
#########################################################

# Allow for aliases after sudo.
alias sudo="sudo "

# Default to clipboard selection in xclip
alias xclip='xclip -selection clipboard'

# Shwo hidden files in nnn.
alias nnn="nnn -d"

alias lkvim="VIM_FMT_OVERRIDE=lk-src vim"
alias killwine='pgrep -f C: |xargs kill && pgrep -f wine |xargs kill'
alias pacman-autoremove="bash -c \"pacman -Qtdq | pacman -Rns -\""

alias gri="grep -rnI . -e"
