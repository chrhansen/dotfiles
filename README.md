# .files

These are my dotfiles. Take anything you want, but at your own risk.

## Highlights

- Minimal efforts to install everything, using a [Makefile](./Makefile)
- Mostly based around Homebrew, Caskroom and Node.js, latest Bash + GNU Utils
- Updated macOS defaults
- Well-organized and easy to customize

## Packages Overview

- [Homebrew](https://brew.sh) (packages: [Brewfile](./install/Brewfile))
- [homebrew-cask](https://github.com/Homebrew/homebrew-cask) (packages: [Caskfile](./install/Caskfile))
- [Node.js + npm LTS](https://nodejs.org/en/download/) (packages: [npmfile](./install/npmfile))
- Latest Git, Bash 4, Python 3, GNU coreutils, curl, Ruby
- `$EDITOR` (and Git editor) is [GNU nano](https://www.nano-editor.org)

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

Use the [Makefile](./Makefile) to install everything [listed above](#package-overview), and symlink [runcom](./runcom)
and [config](./config):

```bash
cd ~/dev/dotfiles
make
```

## Post-Installation

### Turn on "Full Disk Access" for Terminal before applying defaults
On Big Sur/Safari 14 some apps are sandboxed under System Integrity Protection (SIP). This means that if Terminal is not allowed "Full Disk Access" the `defaults write ...` used in macos-settings, Terminal will be editing a plist-file in `~/Library/Preferences/` that is not actually in use by Safari 14. If "Full Disk Access" `defaults write ...` will edit the correct sandboxed plist file for Safari 14. So
Go to Preferences > Security & Privacy > Privacy > Turn on "Full Disk Access" for Terminal. Restart the terminal and then you can run the defaults.

#### Turn off "Full Disk Access" for Terminal after applying defaults
Remember to do this.

- `dotfiles dock` (set [Dock items](./macos/dock.sh))
- `dotfiles macos` (set [macOS defaults](./macos/defaults.sh))
- Mackup
  - Log in to Dropbox (and wait until synced)
  - `ln -s ~/.config/mackup/.mackup.cfg ~` (until [#632](https://github.com/lra/mackup/pull/632) is fixed)
  - `mackup restore`

## The `dotfiles` command

```bash
$ dotfiles help
Usage: dotfiles <command>

Commands:
    clean            Clean up caches (brew, npm, gem, rvm)
    dock             Apply macOS Dock settings
    edit             Open dotfiles in IDE (code) and Git GUI (stree)
    help             This help message
    macos            Apply macOS system defaults
    test             Run tests
    update           Update packages and pkg managers (OS, brew, npm, gem)
```

## Additional Resources

- [Awesome Dotfiles](https://github.com/chrhansen/awesome-dotfiles)
- [Homebrew](https://brew.sh)
- [Homebrew Cask](https://github.com/Homebrew/homebrew-cask)
- [Bash prompt](https://wiki.archlinux.org/index.php/Color_Bash_Prompt)
- [Solarized Color Theme for GNU ls](https://github.com/seebi/dircolors-solarized)

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).
