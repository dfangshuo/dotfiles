# Personal Programs and Installations

*Not to be used for work work dependencies/installations*

## .vimrc
- `ln -s ~/flib/.vimrc ~/`

## .tmux.conf
- `ln -s ~/flib/.tmux.conf ~/`

## .doom.d
- `ln -s ~/flib/.doom.d ~/`

## karabiner-elements

**IMPORTANT:** Symlink the whole `~/.config/karabiner` directory, not individual
files. If you symlink only `karabiner.json`, Karabiner will occasionally replace
the symlink with a fresh blank config on boot (e.g. if it starts before the
symlink target is resolvable) and you'll lose your bindings until you re-link.

### Fresh install
```bash
# Remove any existing config dir (back it up first if you have anything live)
rm -rf ~/.config/karabiner

# Symlink the entire directory
ln -s ~/flib/karabiner ~/.config/karabiner
```

### Recovery (bindings disappeared after a restart)
Symptom: `~/.config/karabiner/karabiner.json` is a tiny ~183-byte file with
a bare "Default profile" and your symlink is gone. Your real config still lives
in `~/flib/karabiner/`. Fix:

```bash
rm -rf ~/.config/karabiner
ln -s ~/flib/karabiner ~/.config/karabiner
launchctl kickstart -k "gui/$(id -u)/org.pqrs.karabiner.karabiner_console_user_server"
```

### Directory layout inside flib
```
~/flib/karabiner/
├── karabiner.json
└── assets/
    └── complex_modifications/
        └── *.json
```

**UI Modifications**
- caps_lock -> left_control
- escape -> return_or_enter
- left_control -> play_or_pause

## Shell
- https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
- https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
- https://github.com/junegunn/fzf#using-homebrew
- `git clone https://github.com/powerline/fonts.git --depth=1`

## Scripts
- ln -s ~/flib/scripts ~/scripts
