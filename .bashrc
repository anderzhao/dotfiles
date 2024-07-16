#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# Alias
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias grep='grep --color=auto'
alias lsg='ls -A | grep -i'
alias psg='ps aux | grep -i'
alias hig='history | grep -i'

## Config git alias
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Env export
export GPG_TTY=$(tty)
export EDITOR='vim'
export HISTCONTROL=ignoreboth

# Funcation
function extract () {
        if [ -f $1 ] ; then
                case $1 in
                        *.tar.bz2)       tar xjf $1                                    ;;
                        *.tar.gz)        tar xzf $1                                    ;;
                        *.bz2)           bunzip2 $1                                    ;;
                        *.rar)           rar x $1                                      ;;
                        *.gz)            gunzip $1                                     ;;
                        *.tar)           tar xf $1                                     ;;
                        *.tbz2)          tar xjf $1                                    ;;
                        *.tgz)           tar xzf $1                                    ;;
                        *.zip)           unzip $1                                      ;;
                        *.Z)             uncompress $1                                 ;;
                        *)               echo "'$1' cannot be extracted via extract()" ;;
                esac
        else
                echo "'$1' is not a valid file"
        fi
}

## Alt+h open command man
run-help() { help "$READLINE_LINE" 2>/dev/null || man "$READLINE_LINE"; }
bind -m vi-insert -x '"\eh": run-help'
bind -m emacs -x     '"\eh": run-help'

# Auto cd in path
shopt -s autocd

# Resize window
shopt -s checkwinsize

# Not found command
source /usr/share/doc/pkgfile/command-not-found.bash

# Completion
source /usr/share/bash-completion/bash_completion
