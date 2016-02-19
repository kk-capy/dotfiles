"---------------------
" Vimrc
"---------------------
let mapleader = " "
"--------------------
syntax on
"256色モード
let t_Co=256
"新しい行のインデントを現在行と同じにする
set autoindent
"変更中のファイルでも、保存しないで他のファイルを表示
set hidden
"インクリメンタルサーチを行う
set incsearch
"行番号を非表示に
set nonumber
"ファイル内の <Tab> が対応する空白の数
set tabstop=4
"タブを挿入するときの幅
set shiftwidth=4
"タブ文字の扱い方
set expandtab "タブ文字の代わりに半角スペースを使用する
set softtabstop=4
"ステータス表示
set laststatus=2
"コマンド表示
set showcmd
"ツールバー非表示
set guioptions-=T
"タブ領域を常に表示
set showtabline=2
"ヤンクの内容をクリップボードと同期
set clipboard=unnamed
"エンコーディング指定
"(内部)
set encoding=utf-8
"(保存)
set fileencoding=utf-8
"エンコーディング自動判別優先順位(utf-8を優先)
"(開くとき)
set fileencodings=utf-8,sjis
"ESCでIMG自動OFF
"inoremap <ESC> <ESC>:set iminsert=0<CR>
"バックアップ作成ディレクトリ
set backupdir=$HOME/.vim/backup
"スワップファイル作成でぃれくとり
set directory=$HOME/.vim/swap
" バックスペースが利かなくなる問題対策
noremap  
noremap!  
"noremap 
"noremap! 
set backspace=2
"全角記号の表示改善(iterm使用の場合は profile>text>DoubleWithCharacter にチェックを入れる必要あり)
set ambiwidth=double

"TAB文字、改行文字などを可視化
"set list
"set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
"(改行)
"highlight NonText guibg=NONE guifg=DarkGreen
"(TAB)
"highlight SpecialKey guibg=NONE guifg=Gray40
" 行末の空白文字を可視化
highlight WhitespaceEOL cterm=bold ctermbg=red guibg=#FF0000
au BufWinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')
au WinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')
" 行頭のTAB文字を可視化
highlight TabSpace cterm=underline ctermfg=blue ctermbg=black guibg=blue
au BufWinEnter * let w:m2 = matchadd("TabSpace", '\t')
au WinEnter * let w:m2 = matchadd("TabSpace", '\t')
" 全角スペースの可視化
highlight ZenkakuSpace cterm=underline ctermbg=red guibg=#666666
au BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
au WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')

" Escキーの反応を早くする
set timeout timeoutlen=1000 ttimeoutlen=75

"vimを閉じずにリネーム
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

" ファイルを作成する際、指定されたディレクトリが存在しなければ再帰的に作成する
augroup vimrc-auto-mkdir  " {{{
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)  " {{{
    if !isdirectory(a:dir) && (a:force ||
    \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction  " }}}
augroup END  " }}}

" 検索箇所を真ん中に
noremap n nzz
noremap N Nzz
noremap * *zz
noremap # #zz
noremap g* g*zz

" スクロール時、カーソルを中央に維持
noremap <C-f> <C-f>z.
noremap <C-b> <C-b>z.

" ctl+pで張付け
noremap <silent> <C-p> "0p<CR>

