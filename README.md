my dotfiles
====

# description

- dotfile types
  - zsh
  - tmux
  - vim
  - (powerline)
  - atom
- TargetOS
  - Linux
  - Mac

# usage

## pre install

事前にインストールする

- zsh
- git
- python + pip
- (mac)HomeBrew
- peco

## (mac)brew install
```(mac)
brew install wget
brew install python 
brew install peco
```

## install pip

powerlineを使用するためにpipをインストールする

```
mkdir ~/tmp
cd ~/tmp
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

pip install --user powerline-status
```

## create .zshrc.local

~/.zshrc.local に独自の環境変数を定義すること
powerlineを使用するには
POWERLINE_PATH="[powerlineのパス]" 
の設定を含める

dotfiles/.zshrc.[hostname]
のファイルが存在すればsetup時に初期設定として使用される


