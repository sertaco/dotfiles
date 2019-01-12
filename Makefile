DOTFILES_DIR := $(HOME)/.dotfiles
OS := $(shell bin/is-supported bin/is-macos macos centos)
PATH := $(DOTFILES_DIR)/bin:$(PATH)
ZSH := $(HOME)/.oh-my-zsh
ZSH_BIN := /bin/zsh
ZSH_V := $(zsh --version | grep 5.6.2)
GO_PACKAGE := 'go1.11.4.linux-amd64.tar.gz'
XDG_CONFIG_HOME := $(HOME)/.config
STOW_DIR := $(DOTFILES_DIR)

all: $(OS)

macos: sudo core-macos packages link
centos: sudo core-centos link

sudo:
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

link: stow-$(OS)
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then mv -v $(HOME)/$$FILE{,.bak}; fi; done
	stow -t $(HOME) runcom

	for FILE in $$(\ls -A runcom/rc-$(OS)); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then mv -v $(HOME)/$$FILE{,.bak}; fi; done
	stow -t $(HOME) --dir $(DOTFILES_DIR)/runcom rc-$(OS)

	mkdir -p $(XDG_CONFIG_HOME)
	stow -t $(XDG_CONFIG_HOME) config
cleanup:
	rm rc-macos rc-centos

#centos
core-centos: zsh-centos
	sudo yum -y install wget git
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch || { echo "Could not install Oh My Zsh" >/dev/stderr exit 1 }
	sudo git clone https://github.com/bhilburn/powerlevel9k.git $(ZSH)/custom/themes/powerlevel9k || echo "Powerlevel9k already installed"
	echo $(ZSH_BIN) | sudo tee -a /etc/shells
	chsh -s $(ZSH_BIN)
	wget https://dl.google.com/go/$(GO_PACKAGE)
	sudo tar -C /usr/local -xzf $(GO_PACKAGE)
	sudo rm $(GO_PACKAGE)

zsh-centos:
	ifeq ($(ZSH_V),)
		sudo yum -y install wget git
		sudo yum -y install ncurses-devel
		wget https://sourceforge.net/projects/zsh/files/zsh/5.6.2/zsh-5.6.2.tar.xz
		sudo tar -xJf zsh-5.6.2.tar.xz && cd zsh-5.6.2 && ./configure --prefix=/usr --bindir=/bin && make && sudo make install
		rm -rf zsh-5.6.2 zsh-5.6.2.tar.xz
	endif

stow-centos:
	is-executable stow || sudo yum -y install stow

#macos
core-macos: brew zsh git

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | ruby
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile

zsh: brew
	brew install zsh zsh-completions
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch || {echo "Could not install Oh My Zsh" >/dev/stderr exit 1}
	sudo git clone https://github.com/bhilburn/powerlevel9k.git $(ZSH)/custom/themes/powerlevel9k || echo "Powerlevel9k already installed"

git: brew
	brew install git git-extras

stow-macos: brew
	is-executable stow || brew install stow

packages: brew-packages

brew-packages: brew



