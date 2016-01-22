
HOSTNAME=`hostname -s`
LOCAL_ZSHRC_PATH="$HOME/dotfiles/.zshrc.$HOSTNAME"
[ -f $LOCAL_ZSHRC_PATH ] && source $LOCAL_ZSHRC_PATH

# powerline
if [ -n "$PYTHON_PATH" ]; then
  export PATH=$PATH:$PYTHON_PATH/bin
  powerline-daemon -q
  . $PYTHON_PATH/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh
fi

# zplugがインストールされていなければインストールする
[[ -d ~/.zplug ]] || {
  curl -fLo ~/.zplug/zplug --create-dirs https://git.io/zplug
  source ~/.zplug/zplug && zplug update --self
}

# zplugを読み込む
source ~/.zplug/zplug

# プラグイン
zplug "zsh-users/zsh-syntax-highlighting" # シンタックスハイライト
zplug "zsh-users/zsh-history-substring-search" # コマンドライン履歴から単語を補完する
zplug "mollifier/cd-bookmark" # ディレクトリのお気に入りを管理
zplug "djui/alias-tips" # 入力したコマンドにエイリアスがあれば教えてくれる
zplug "rimraf/k" # lsより見やすい一覧
#zplug "b4b4r07/enhancd", of:enhancd.sh # kと競合する？
zplug "arialdomartini/oh-my-git"
zplug "stedolan/jq", \
  as:command, \
  file:jq, \
  from:gh-r \
  | zplug "b4b4r07/emoji-cli" # 絵文字入力補助

# check コマンドで未インストール項目があるかどうか verbose にチェックし
# false のとき（つまり未インストール項目がある）y/N プロンプトで
# インストールする
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# プラグインを読み込み、コマンドにパスを通す
zplug load --verbose

# コマンド補完を有効化
autoload -U compinit
compinit

# ヒストリ(履歴)を保存、数を増やす
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY # 開始と終了を記録
setopt share_history # 異なるセッション間で共有
setopt hist_ignore_dups # 同じコマンドラインを連続で実行した場合は登録しない
# pecoとの連携
function peco-history-selection() {
  BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# エイリアス
alias la='ls -la'
alias cdb='cd-bookmark'
alias vg='vagrant'
alias npmgl='npm list -g | grep "^[├└]"'
alias t='tmux'
alias ta='tmux attach'
alias fe='forever'
alias ka='k -a'
alias usbserial='screen `ls /dev/cu.usbserial-*` 115200 -L'
alias reload='exec zsh -l'
alias zshrc='vi ~/.zshrc'

