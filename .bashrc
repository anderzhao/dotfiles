#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\n\$ "

# Alias
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias grep='grep --color=auto'
alias lsg='ls -A | grep -i'
alias psg='ps aux | grep -i'
alias hig='history | grep -i'
alias vim='nvim'
alias cat='bat'

## Config git alias
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Env export
export GPG_TTY=$(tty)
export EDITOR='vim'
export HISTCONTROL=ignoreboth
# for complier
# export LDFLAGS="-L/opt/homebrew/opt/curl/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/curl/include"

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

## Ctrl+h open command man
run-help() { help "$READLINE_LINE" 2>/dev/null || man "$READLINE_LINE"; }
bind -m vi-insert -x '"C-h": run-help'
bind -m emacs -x     '"C-h": run-help'

# Completion
source /opt/homebrew/etc/bash_completion
