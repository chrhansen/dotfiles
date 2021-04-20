SHELL = /bin/bash
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
OS := $(shell bin/is-supported bin/is-macos macos linux)
PATH := $(DOTFILES_DIR)/bin:$(PATH)
NVM_DIR := $(HOME)/.nvm
export XDG_CONFIG_HOME = $(HOME)/.config
export ACCEPT_EULA=Y

.PHONY: test

all: $(OS)

macos: sudo core-macos packages oh-my-zsh vscode

linux: core-linux

core-macos: brew bash git npm ruby

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
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

bash: BASH=/usr/local/bin/bash
bash: SHELLS=/private/etc/shells
bash: brew
ifdef GITHUB_ACTION
	if ! grep -q $(BASH) $(SHELLS); then \
		brew install bash bash-completion@2 pcre && \
		sudo append $(BASH) $(SHELLS) && \
		sudo chsh -s $(BASH); \
	fi
else
	if ! grep -q $(BASH) $(SHELLS); then \
		brew install bash bash-completion@2 pcre && \
		sudo append $(BASH) $(SHELLS) && \
		chsh -s $(BASH); \
	fi
endif

git: brew
	brew install git

npm:
	if ! [ -d $(NVM_DIR)/.git ]; then git clone https://github.com/creationix/nvm.git $(NVM_DIR); fi
	. $(NVM_DIR)/nvm.sh; nvm install --lts

ruby: brew
	brew install ruby

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile

cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true

node-packages: npm
	. $(NVM_DIR)/nvm.sh; npm install -g $(shell cat install/npmfile)

test:
	. $(NVM_DIR)/nvm.sh; bats test

oh-my-zsh:
	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
	cp config/oh-my-zsh/.zshrc ~/.zshrc

vscode:
	cp macos/vscode/settings.json $(HOME)/Library/Application\ Support/Code/User/settings.json
	cp macos/vscode/keybindings.json $(HOME)/Library/Application\ Support/Code/User/keybindings.json
	cat macos/vscode/extensions.txt | xargs -L 1 code --install-extension
