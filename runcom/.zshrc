export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


source $ZSH/oh-my-zsh.sh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=23'

#MAC bindings
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

eval "$(direnv hook zsh)"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# added by Snowflake SnowSQL installer v1.0
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
