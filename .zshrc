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

# ヒストリ(履歴)を保存、数を増やす
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# エイリアス
alias la='ls -la'
alias cdb='cd-bookmark'
alias vg='vagrant'
alias npmgl='npm list -g | grep "^[├└]"'
#alias tm='tmux -CC'
#alias ta='tmux -CC attach'
alias fe='forever'

