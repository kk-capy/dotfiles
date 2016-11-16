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

# zsh
ln -s "$DOTFILES/.zshrc" "$HOME/.zshrc"
# zsh(環境依存)
[ -e "$DOTFILES/.zshrc.$HOSTNAME" ] && ln -s "$DOTFILES/.zshrc.$HOSTNAME" "$HOME/.zshrc.local"
# powerline
[ ! -d "$HOME/.config" ] && mkdir "$HOME/.config"
ln -s $DOTFILES/$POWERLINECONF $HOME/.config/
# tmux
ln -s "$DOTFILES/$TMUXCONF" "$HOME/$TMUXCONF"
# gitconfig
[ ! -d "$HOME/.gitconfig" ] && ln -s "$DOTFILES/.gitconfig" "$HOME/.gitconfig"

echo "usage:"

