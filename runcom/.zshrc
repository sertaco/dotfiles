export WORKSPACE="$HOME/workspace"
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=vim

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

source "$DOTFILES_DIR/system/.env"
source "$DOTFILES_DIR/system/.prompt"
source $WORKSPACE/guessfair/gfrc.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

source $ZSH/oh-my-zsh.sh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=23'


# Source the dotfiles (order matters)
#for DOTFILE in "$DOTFILES_DIR"/system/.{prompt,function,env,alias}; do
#  [ -f "$DOTFILE" ] && . "$DOTFILE"
#done

#if is-macos; then
#  for DOTFILE in "$DOTFILES_DIR"/system/.{env,alias,function,path}.macos; do
#    [ -f "$DOTFILE" ] && . "$DOTFILE"
#  done
#fi


#MAC bindings
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line


#Go

export PATH=$PATH:/usr/local/go/bin

#
#export GOPATH="${HOME}/.go"
#export GOROOT="$(brew --prefix golang)/libexec"
#export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
#test -d "${GOPATH}" || mkdir "${GOPATH}"
#test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"


[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

#function show_virt_env() {
#    if [ -n "$VIRTUAL_ENV" ]; then
#	echo "($(basename $VIRTUAL_ENV))"
#    fi
#}

eval "$(direnv hook zsh)"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export PATH=$PATH:"/Users/granularity/.local/bin"

#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH=/usr/local/Cellar/aws-sam-cli/0.14.2/bin:$PATH

export PATH=/usr/local/Cellar/postgresql/11.3/bin/:$PATH

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# added by Snowflake SnowSQL installer v1.0
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
