cp settings.json $HOME/Library/Application\ Support/Code/User/settings.json
cp keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json
cat extensions.txt | xargs -L 1 code --install-extension
