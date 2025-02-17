# If you come from bash you might have to change your $PATH.
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/Users/chrh/.oh-my-zsh"

# For signed git-commits, https://github.com/microsoft/vscode/issues/130415
export GPG_TTY=$(tty)

export GOOGLE_APPLICATION_CREDENTIALS="json-file-path"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
ZSH_DISABLE_COMPFIX=true

plugins=(git asdf)

source $ZSH/oh-my-zsh.sh

export GITHUB_USERNAME="chrhansen"
export GITHUB_TOKEN=
export BUNDLE_RUBYGEMS__PKG__GITHUB__COM=$GITHUB_TOKEN

alias python=/usr/bin/python3

source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
