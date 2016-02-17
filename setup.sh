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

DIR=$(cd $(dirname $0); pwd)
ZSHRC=".zshrc"
HOSTNAME=`hostname`
TMUXCONF=".tmux.conf"
POWERLINECONF="powerline"

[ -d "$HOME/.config" ] && mkdir ~/.config

if [ ! -d "$HOME/.config/$POWERLINECONF" ]; then
  ln -s $DIR/.config/$POWERLINECONF $HOME/.config/
else
  echo "$POWERLINECONF already exist"
fi

if [ ! -e "$HOME/$ZSHRC" ]; then
  ln -s "$DIR/$ZSHRC" "$HOME/$ZSHRC"
else
  echo "$ZSHRC already exist"
fi

if [ ! -e "$HOME/$TMUXCONF" ]; then
  ln -s "$DIR/$TMUXCONF" "$HOME/$TMUXCONF"
else
  echo "$TMUXCONF already exist"
fi

