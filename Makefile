SHELL = /bin/bash
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
OS := $(shell bin/is-supported bin/is-macos macos linux)
PATH := $(DOTFILES_DIR)/bin:$(PATH)
HOMEBREW_PREFIX := $(shell bin/is-supported bin/is-arm64 /opt/homebrew /usr/local)
export XDG_CONFIG_HOME = $(HOME)/.config
export ACCEPT_EULA=Y

.PHONY: test

all: $(OS)

macos: sudo oh-my-zsh core-macos packages vscode

linux: core-linux

core-macos: brew git npm ruby

core-linux:
	apt-get update
	apt-get upgrade -y
	apt-get dist-upgrade -f

sudo:
ifndef GITHUB_ACTION
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
endif

packages: brew-packages cask-apps node-packages

brew:
	is-executable brew || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

bash: BASH=$(HOMEBREW_PREFIX)/bin/bash
bash: SHELLS=/private/etc/shells
bash: brew
	if ! grep -q $(BASH) $(SHELLS); then \
		brew install bash bash-completion@2 pcre && \
		sudo append $(BASH) $(SHELLS) && \
		chsh -s $(BASH); \
	fi

git: brew
	brew install git

npm: brew-packages
	fnm install --lts

ruby: brew
	brew install ruby

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile || true

cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true

node-packages: npm
	eval $$(fnm env); npm install -g $(shell cat install/npmfile)

oh-my-zsh:
	ZSH=
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	cp config/oh-my-zsh/.zshrc ~/.zshrc

vscode:
	mkdir -p $(HOME)/Library/Application\ Support/Code/User/
	cp macos/vscode/settings.json $(HOME)/Library/Application\ Support/Code/User/settings.json
	cp macos/vscode/keybindings.json $(HOME)/Library/Application\ Support/Code/User/keybindings.json
	cat macos/vscode/extensions.txt | xargs -L 1 code --install-extension
