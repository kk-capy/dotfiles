#!/bin/sh

#----
# dotfilesをカレントディレクトリに配置
# (for unix)
#----
#
### powerlineのインストール
# pip install powerline-status
# (Mac)
# brew install python
# pip install --user powerline-status

DIR=$(cd $(dirname $0); pwd)
ZSHRC=".zshrc"
TMUXCONF=".tmux.conf"
POWERLINECONF="powerline"

[ -d "$HOME/.config" ] && mkdir ~/.config

if [ ! -d "$HOME/.config/$POWERLINECONF" ]; then
  cp -rf $DIR/$POWERLINECONF ~/.config/
else
  echo "$POWERLINECONF already exist"
fi

if [ ! -e "$HOME/$ZSHRC" ]; then
  cp -f "$DIR/$ZSHRC" "$HOME/$ZSHRC"
else
  echo "$ZSHRC already exist"
fi

if [ ! -e "$HOME/$TMUXCONF" ]; then
  cp -f "$DIR/$TMUXCONF" "$HOME/$TMUXCONF"
else
  echo "$TMUXCONF already exist"
fi

