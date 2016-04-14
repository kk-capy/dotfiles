#!/bin/bash
#
# create symbolic link to ~/.atom/*
DIR=$(cd $(dirname $0); pwd)

for f in config.cson init.coffee keymap.cson snippets.cson styles.less
do
  echo ln $f
  ln -s $DIR/$f ~/.atom/
done
