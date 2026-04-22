# ~/.bashrc - pataccone (Void Linux TTY)

# Fix TERM via SSH
export TERM=xterm-256color

# Se non interattivo esci subito
[[ $- != *i* ]] && return

# History
HISTSIZE=100000
HISTFILESIZE=200000
HISTCONTROL=ignoredups:erasedups:ignorespace
HISTTIMEFORMAT="%d/%m/%y %T "
HISTIGNORE="ls:ll:la:l:cd:clear:history"
shopt -s histappend
PROMPT_COMMAND="history -a; history -n"

# Finestra
shopt -s checkwinsize

# Prompt colorato per TTY linux
case "$TERM" in
    linux|xterm*|screen*)
        PS1='\[\033[01;36m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
        ;;
    *)
        PS1='\u@\h:\w\$ '
        ;;
esac

# Colori ls e grep
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ls alias
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Utilità
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ip='ip -c'

# Editor
export EDITOR=vim
export VISUAL=vim

# Bash completion
if [ -f /etc/bash/bashrc.d/bash_completion.sh ]; then
    . /etc/bash/bashrc.d/bash_completion.sh
fi

# AI da terminale
alias ai='aichat'
alias aic='aichat --session'

alias aigrok='aichat -m xai:grok-3'
alias aigrok-mini='aichat -m xai:grok-3-mini'
export PATH="$HOME/bin:$PATH"
