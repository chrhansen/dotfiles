# .files

These are my ~~dotfiles~~ install-files. Take anything you want, but at your own risk.

## Highlights

- Mostly based around Homebrew and Caskroom.
- Updated macOS defaults

## Packages Overview

- [Homebrew](https://brew.sh) (packages: [Brewfile](./install/Brewfile))
- [homebrew-cask](https://github.com/Homebrew/homebrew-cask) (packages: [Caskfile](./install/Caskfile))

## Installation

On a sparkling fresh installation of macOS:

```bash
sudo softwareupdate -i -a
xcode-select --install
```

The Xcode Command Line Tools includes `git` and `make` (not available on stock macOS). Now:

```bash
git clone https://github.com/chrhansen/dotfiles.git ~/dev/dotfiles
```

### Installs
Manually copy-paste installs from manual-make

### Mac Defaults/Config
Manually copy-paste the three .sh files in macos-folders

Done.
