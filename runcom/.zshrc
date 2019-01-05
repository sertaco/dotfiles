#!/bin/zsh
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=vim

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

alias rvm-prompt=$HOME/.rvm/bin/rvm-prompt
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_CUSTOM="$ZSH/custom"
ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv ssh aws  status root_indicator background_jobs history public_ip time)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv newline vcs)

POWERLEVEL9K_PROMPT_ON_NEWLINE=false
POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="↱"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="↳ "

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/.config/mdp/mdprc

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
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"


[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

function show_virt_env() {
    if [ -n "$VIRTUAL_ENV" ]; then
	echo "($(basename $VIRTUAL_ENV))"
    fi
}

eval "$(direnv hook zsh)"
