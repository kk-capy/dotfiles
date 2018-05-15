#!/bin/sh

#----
# dotfilesをカレントディレクトリに配置
# (for unix)
#----
#
# == powerline ==
#
# (Linux)
# pip install powerline-status
# (Mac)
# brew install python
# pip install --user powerline-status
#
# == tmux ==
# TODO:
#
# == tpm ==
#
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

DOTFILES=$(cd $(dirname $0); pwd)
HOSTNAME=`hostname`
TMUXCONF=".tmux.conf"
POWERLINECONF="powerline"

function createSymlink () {
  if [ ! -e "$HOME/$1" ]; then
    ln -s "$DOTFILES/$1" "$HOME/$1"
    echo "create symlink ($1)"
  else
    echo "$HOME/$1 is already exist"
  fi
}

# zsh
createSymlink ".zshrc"

# zsh(環境依存)
if [ ! -e "$HOME/.zshrc.local" ]; then
  if [ -e "$DOTFILES/.zshrc.$HOSTNAME" ]; then
    cp "$DOTFILES/.zshrc.$HOSTNAME" "$HOME/.zshrc.local"
  else
    cp "$DOTFILES/.zshrc.default" "$HOME/.zshrc.local"
  fi
fi

# powerline
if [ ! -d "$HOME/.config" ]; then
  ln -s $DOTFILES/$POWERLINECONF $HOME/.config/
fi

# tmux
createSymlink $TMUXCONF

# gitconfig
createSymlink ".gitconfig"
createSymlink ".gitmessage.txt"

echo "setup success!"

