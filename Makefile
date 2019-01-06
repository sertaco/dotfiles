DOTFILES_DIR := $(HOME)/.dotfiles
OS := $(shell bin/is-supported bin/is-macos macos centos)
PATH := $(DOTFILES_DIR)/bin:$(PATH)
ZSH := $(HOME)/.oh-my-zsh
ZSH_BIN := /usr/bin/zsh
GO_PACKAGE := 'go1.11.4.linux-amd64.tar.gz'

export XDG_CONFIG_HOME := $(HOME)/.config
export STOW_DIR := $(DOTFILES_DIR)
all: $(OS)

macos: sudo core-macos packages link
centos: sudo core-centos link

sudo:
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
link: stow-$(OS)
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p $(XDG_CONFIG_HOME)
	stow -t $(HOME) runcom
	stow -t $(HOME) rc-$(OS)
	stow -t $(XDG_CONFIG_HOME) config

#centos
core-centos:
#	yum check-update
#	yum update
	sudo yum -y install zsh wget git
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch || {echo "Could not install Oh My Zsh" >/dev/stderr exit 1}
	sudo git clone https://github.com/bhilburn/powerlevel9k.git $(ZSH)/custom/themes/powerlevel9k || echo "Powerlevel9k already installed"
	chsh -s $(ZSH_BIN)
	wget https://dl.google.com/go/$(GO_PACKAGE)
	sudo tar -C /usr/local -xzf $(GO_PACKAGE)
	sudo rm $(GO_PACKAGE)

stow-centos:
	is-executable stow || sudo yum -y install stow

#macos
core-macos: brew zsh git

stow-macos: brew
	is-executable stow || brew install stow

git: brew
	brew install git git-extras

packages: brew-packages
brew-packages: brew

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | ruby
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile

zsh: brew
	brew install zsh zsh-completions
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch || {echo "Could not install Oh My Zsh" >/dev/stderr exit 1}
	sudo git clone https://github.com/bhilburn/powerlevel9k.git $(ZSH)/custom/themes/powerlevel9k || echo "Powerlevel9k already installed"

cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile
	defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
	for EXT in $$(cat install/Codefile); do code --install-extension $$EXT; done

