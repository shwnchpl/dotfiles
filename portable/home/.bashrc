######################################
# .bashrc - Custom Bash configuration.
######################################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Update screen window title with the program that's currently running.
case "$TERM" in
  screen*)
    PS1='\[\033k\033\\\]'
    ;;
  *)
    PS1=""
    ;;
esac

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]'$PS1'\$ '
    # Uncomment to include Git branch in prompt. For reference, see
    # https://coderwall.com/p/fasnya/add-git-branch-name-to-bash-prompt.
    # PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[31m\]$(parse_git_branch)\[\e[0m\]\n'$PS1'\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w'$PS1'\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

set -o vi

# Utility to open all files containing some pattern in Vim.
vimallwith() { grep --color=none -rIl $1 . | xargs bash -c '</dev/tty vim "$@"' ignoreme; }

# If vivid is present, use it to configure LS_COLORS theme.
# This may need to be commented out if 256 color support is not
# available.
if [ -x "$(command -v vivid)" ]; then
  export LS_COLORS=$(vivid -m 8-bit generate molokai)
fi

# Load SSH configuration.
[ -f $HOME/.bash_ssh ] && . $HOME/.bash_ssh

if [ -f ~/.fzf.bash ]; then
    # fzf Bash extensions have been installed.
    source ~/.fzf.bash
elif [ -f $(which fzf) ]; then
    # fzf Bash extensions haven't been installed, but we do
    # have fzf, so we may have extensions.
    if [ -d "/usr/share/doc/fzf/examples" ]; then
        # Debian puts them here, for example.
        [[ $- == *i* ]] && \
            source "/usr/share/doc/fzf/examples/completion.bash" 2> /dev/null
        source "/usr/share/doc/fzf/examples/key-bindings.bash" 2> /dev/null
    elif [ -d "/usr/share/fzf" ]; then
        # Arch puts them here.
        [[ $- == *i* ]] && \
            source "/usr/share/fzf/completion.bash" 2> /dev/null
        source "/usr/share/fzf/key-bindings.bash" 2> /dev/null
    fi
fi

# Add "quitcd" nnn support.
export NNN_TMPFILE="/tmp/nnn"
n()
{
        nnn "$@"

        if [ -f $NNN_TMPFILE ]; then
                . $NNN_TMPFILE
                rm -f $NNN_TMPFILE > /dev/null
        fi
}

# Load Bash environment variables.
if [[ -f ~/.bash_env ]]; then
    prepend_path()
    {
        mkdir -p $1 2> /dev/null || return
        case ":$PATH:" in
            *:"$1":*)   ;;
            *)          PATH=$1${PATH:+:$PATH}
        esac
    }
    . ~/.bash_env
    unset -f prepend_path
fi
