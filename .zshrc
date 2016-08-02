
# 環境毎の設定ファイルを読み込む
# 端末別
LOCAL_ZSHRC_PATH="$HOME/.zshrc.local"
[ -f $LOCAL_ZSHRC_PATH ] && source $LOCAL_ZSHRC_PATH
# OS種別
OSTYPE_ZSHRC_PATH="$HOME/dotfiles/.zshrc.`uname`"
[ -f $OSTYPE_ZSHRC_PATH ] && source $OSTYPE_ZSHRC_PATH

# powerline
if [ -n "$POWERLINE_PATH" ]; then
  powerline-daemon -q
  . $POWERLINE_PATH/bindings/zsh/powerline.zsh
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
zplug "mollifier/anyframe" # pecoなどのインクリメンタルサーチを組み合わせて便利にする

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

# cdrを有効化
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
## cdr設定
#zstyle ':completion:*' recent-dirs-insert both
#zstyle ':chpwd:*' recent-dirs-max 500
#zstyle ':chpwd:*' recent-dirs-default true
#zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
#zstyle ':chpwd:*' recent-dirs-pushd true

# エイリアス
alias la='ls -la'
alias cdb='cd-bookmark'
alias vg='vagrant'
alias npmgl='npm list -g | grep "^[├└]"'
alias t='tmux'
alias ta='tmux attach'
alias tat='tmux attach -t'
alias tl='tmux ls'
alias fe='forever'
alias ka='k -a'
alias usbserial='screen `ls /dev/cu.usbserial-*` 115200 -L'
alias reload='exec zsh -l'
alias zshrc='vi ~/.zshrc'
alias cdr=anyframe-widget-cdr
alias rn='react-native'

