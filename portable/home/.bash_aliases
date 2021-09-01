# Allow for aliases after sudo.
alias sudo="sudo "

alias lkvim="VIM_FMT_OVERRIDE=lk-src vim"
alias killwine='pgrep -f C: |xargs kill && pgrep -f wine |xargs kill'
alias pacman-autoremove="bash -c \"pacman -Qtdq | pacman -Rns -\""
