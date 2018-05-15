#!/bin/bash


# check OS
if [ "$(uname)" == 'Darwin' ]; then
  OS="mac"
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  OS="linux"
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then                                                                                           
  OS="cygwin"
else
  OS="unknown"
fi
echo "OS => $OS"

function notice () {
  echo "---------------------"
  echo $1
  echo "---------------------"
}

# 作業ディレクトリの作成
if [ ! -e ~/tmp ]; then
  mkdir ~/tmp
fi

# git
if which git > /dev/null 2>&1; then
  notice "git found"
else
  notice "git not found"
  if [ "$OS" == 'linux' ]; then
    yum install git
  else
    echo "TODO:other os"
  fi
fi

# zsh
if which zsh > /dev/null 2>&1; then
  notice "zsh found"
else
  notice "zsh not found"
  if [ "$OS" == 'linux' ]; then
    yum install zsh
    chsh -s /bin/zsh
  else
    echo "TODO:other os"
  fi
fi

# zplug
if [ -e ~/.zplug ]; then
  notice "zplug found"
elif [ which zsh > /dev/null 2>&1; ]; then
  notice "zplug install"
  if [ "$OS" == 'linux' ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  else
    echo "TODO:other os"
  fi
fi

# pip and powerline-status
if which pip > /dev/null 2>&1; then
  notice "pip found"
else
  notice "pip install"
  if [ "$OS" == 'linux' ]; then
    wget https://bootstrap.pypa.io/get-pip.py ~/tmp/get-pip.py
    python ~/tmp/get-pip.py
    pip install powerline-status
  else
    echo "TODO:other os"
  fi
fi

# tmux
if which tmux > /dev/null 2>&1; then
  notice "tmux found"
else
  notice "tmux install"
  if [ "$OS" == 'linux' ]; then
    yum install tmux
  else
    echo "TODO:other os"
  fi
fi

# peco
if which peco > /dev/null 2>%1; then
  notice "peco found"
else
  notice "peco install"
  if [ "$OS" == 'linux' ]; then
    wget https://github.com/peco/peco/releases/download/v0.5.3/peco_linux_386.tar.gz -P ~/tmp
    tar -C ~/tmp -xzf ~/tmp/peco_linux_386.tar.gz
    mv ~/tmp/peco_linux_386/peco /usr/local/bin/
  else
    echo "TODO:other os"
  fi
fi


