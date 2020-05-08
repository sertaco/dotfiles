#export ZDOTDIR=$HOME/.config/zsh
export DOTFILES_DIR=$HOME/.dotfiles

source "$DOTFILES_DIR/system/.env"
source "$DOTFILES_DIR/system/.prompt"
source "$DOTFILES_DIR/system/.alias"
source $WORKSPACE/guessfair/gfrc.sh


export WORKSPACE="$HOME/workspace"
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=vim

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

export KUANTIC_USER=LP2020
export KUANTIC_PASS=ofea9ff-PPmX

export gdstr=213.14.226.129
export gdsvpn=3.9.125.198


[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"


# Set PATH
PATH=$HOME/bin:/usr/local/bin:$PATH

#Go

export PATH=$PATH:/usr/local/go/bin

#
#export GOPATH="${HOME}/.go"
#export GOROOT="$(brew --prefix golang)/libexec"
#export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
#test -d "${GOPATH}" || mkdir "${GOPATH}"
#test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

export PATH=$PATH:"/Users/granularity/.local/bin"
export PATH=/usr/local/Cellar/aws-sam-cli/0.14.2/bin:$PATH
export PATH=/usr/local/Cellar/postgresql/11.3/bin/:$PATH

[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'
