# Yolk configured dotfiles

all are stored in the eggs directory & yolk.rhai configures what goes where, as well as whether to put or merge those files

## How to use
Dependencies: git, yolk, ...

```bash
git clone https://github.com/Pallaxis/yolk-dotfiles.git ~/.config/yolk # check this is right
yolk sync
# resolve any conflicts, i.e xdg-dir file in config

# this part will write configs for /etc/ and install packages
cd ~/.local/share/system-setup/
./install.sh
```

## Why yolk over stow?

yolk allows me to create template files that will apply based on hostname, but keeps a consistent file to track with git right before committing, no matter what machine i'm on
