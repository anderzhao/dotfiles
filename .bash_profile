#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# XDG
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.data
export XDG_STATE_HOME=~/.state

# Fcitx5
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
