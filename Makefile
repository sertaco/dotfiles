DOTFILES_DIR := $(HOME)/.dotfiles
OS := $(shell bin/set_os.sh)
PATH := $(DOTFILES_DIR)/bin:$(PATH)
ZSH := $(HOME)/.oh-my-zsh
ZSH_BIN := /bin/zsh
ZSH_V := $(shell zsh --version | grep 5.6.2)
GO_PACKAGE := 'go1.11.4.linux-amd64.tar.gz'
XDG_CONFIG_HOME := $(HOME)/.config
STOW_DIR := $(DOTFILES_DIR)

all: $(OS)

set-os:
	. ./bin/set_os.sh
	echo $(OpSys)
	echo $(SHELL)
	echo $(testv)


macos: sudo core-macos packages-macos link
centos: sudo core-centos packages-centos link
ubuntu: 
	echo "Hi"

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

#centos
core-centos:
	sudo yum -y install wget git

packages-centos: zsh-centos go-centos

go-centos:
	is-executable go || { wget https://dl.google.com/go/$(GO_PACKAGE) && sudo tar -C /usr/local -xzf $(GO_PACKAGE) &&  sudo rm $(GO_PACKAGE); }

zsh-centos:
ifdef ZSH_V
	@echo "ZSH already installed"
else
	sudo yum -y install wget git
	sudo yum -y install ncurses-devel
	wget https://sourceforge.net/projects/zsh/files/zsh/5.6.2/zsh-5.6.2.tar.xz
	sudo tar -xJf zsh-5.6.2.tar.xz && cd zsh-5.6.2 && ./configure --prefix=/usr --bindir=/bin && make && sudo make install
	rm -rf zsh-5.6.2 zsh-5.6.2.tar.xz
endif
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch || {echo "Could not install Oh My Zsh" >/dev/stderr exit 1}
	echo $(ZSH_BIN) | sudo tee -a /etc/shells
	chsh -s $(ZSH_BIN)
	sudo git clone https://github.com/bhilburn/powerlevel9k.git $(ZSH)/custom/themes/powerlevel9k || echo "Powerlevel9k already installed"

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

packages-macos: brew-packages

brew-packages: brew



