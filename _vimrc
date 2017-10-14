"dein Scripts-----------------------------
let s:dein_dir = expand('~/.vim/bundle')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &compatible
  set nocompatible               " Be iMproved
endif

if !isdirectory(s:dein_repo_dir)
				execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

" Required:
set runtimepath+=~/.vim/bundle/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " Let dein manage dein
  " Required:
  call dein#add(s:dein_repo_dir)

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })
  call dein#add('Shougo/unite.vim')
	call dein#add('Shougo/neomru.vim')
	call dein#add('Shougo/neocomplcache.vim')
	call dein#add('Shougo/neocomplcache-rsense.vim')
	call dein#add('tpope/vim-fugitive')
	call dein#add('kmnk/vim-unite-giti')

  call dein#add('scrooloose/nerdtree')

	" colorscheme
	call dein#add('sjl/badwolf')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" tab幅
set tabstop=2
" 入力中のコマンドをステータスに表示
set showcmd

syntax on
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の列を強調表示（縦）
set cursorcolumn
" 256色対応
set t_Co=256
" エンコーディング
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
" 改行コード
set fileformats=unix,dos,mac
" インデントはスマートインデント
set smartindent
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" カラースキーム
colorscheme badwolf
" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//e
" 開いたときにツリーを表示
autocmd VimEnter * execute 'NERDTree'

"検索系の設定
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列をヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライトする
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" カレントディレクトを自動的に移動
set autochdir
" INSERT MODEから抜ける
inoremap <silent>jj <ESC>

" スクロールの開始位置を調整
set scrolloff=5

"------------------------------------
"" unite.vim
"------------------------------------
"" 入力モードで開始する
let g:unite_enable_start_insert=0
" バッファ一覧
noremap <C-U><C-B> :Unite buffer<CR>
" ファイル一覧
noremap <C-U><C-F> :UniteWithBufferDir -buffer-name=files file<CR>
" 最近使ったファイルの一覧
noremap <C-U><C-R> :Unite file_mru<CR>
" レジスタ一覧
noremap <C-U><C-Y> :Unite -buffer-name=register register<CR>
" ファイルとバッファ
noremap <C-U><C-U> :Unite buffer file_mru<CR>
" 全部
noremap <C-U><C-A> :UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

"--------------------------------------
" NERDTree
" -------------------------------------
map <C-n> :NERDTreeToggle<CR>

"-------------------------------------
" HELP JP
"-------------------------------------
set runtimepath+=~/.vim/bundle/repos/github.com/vimdoc-ja
let s:vimdoc='~/.vim/bundle/repos/github.com/vimdoc-ja'
if !isdirectory(s:vimdoc)
				"1回だけ実行
				"execute '!git clone https://github.com/vim-jp/vimdoc-ja.git' s:vimdoc
endif
helptags ~/.vim/bundle/repos/github.com/vimdoc-ja/doc
set helplang=ja,en

"-------------------------------------
" neocomplcacheの設定
"-------------------------------------
" Disable AutoComplPop
let g:acp_enableAtStartup = 0

" Use neocomplcache
let g:neocomplcache_enable_at_startup = 1

" Use smartcase
let g:neocomplcache_enable_smart_case = 1

" Set minimum syntax keyword length
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1

"-------------------------------------
" Rsense用の設定
"-------------------------------------
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

"rsenseのインストールフォルダがデフォルトと異なるので設定
let g:rsenseHome = expand("~/.rbenv/shims/rsense")
let g:rsenseUseOmniFunc = 1

"-------------------------------------
" Unite-gitiの設定
"-------------------------------------
" Uniteの設定
" Uniteは要素の絞り込み、要素へのアクションができるプラグインです
" 例えば`:Unite file`ではファイルへ操作を行うことができます
" 詳しい使い方については下記を参照してください
" http://d.hatena.ne.jp/osyo-manga/20130307/1362621589
let g:giti_git_command = executable('hub') ? 'hub' : 'git'
nnoremap <silent>gm :Gcommit<CR>
nnoremap <silent>gM :Gcommit --amend<CR>
nnoremap <silent>gb :Gblame<CR>
nnoremap <silent>gB :Gbrowse<CR>

let g:fugitive_git_executable = executable('hub') ? 'hub' : 'git'
nnoremap <silent>gs :Unite giti/status -horizontal<CR>
nnoremap <silent>gl :Unite giti/log -horizontal<CR>
nnoremap <silent>gs :Unite giti/status -horizontal<CR>
nnoremap <silent>gh :Unite giti/branch_all<CR>

"vim-unite-giti {{{
" `:Unite giti/status`, `:Unite giti/branch`, ` :Unite
"giti/log`などを起動した
" 後に、各コマンドに合わせた設定を反映します
augroup UniteCommand
	autocmd!
  autocmd FileType unite call <SID>unite_settings()
augroup END

function! s:unite_settings() "{{{
  for source in unite#get_current_unite().sources
    let source_name = substitute(source.name, '[-/]', '_', 'g')
    if !empty(source_name) && has_key(s:unite_hooks, source_name)
      call s:unite_hooks[source_name]()
    endif
  endfor
endfunction"}}}

let s:unite_hooks = {}

function! s:unite_hooks.giti_status() "{{{
  nnoremap <silent><buffer><expr>gM unite#do_action('ammend')
  nnoremap <silent><buffer><expr>gm unite#do_action('commit')
  nnoremap <silent><buffer><expr>ga unite#do_action('stage')
  nnoremap <silent><buffer><expr>gc unite#do_action('checkout')
  nnoremap <silent><buffer><expr>gd unite#do_action('diff')
  nnoremap <silent><buffer><expr>gu unite#do_action('unstage')
endfunction"}}}

function! s:unite_hooks.giti_branch() "{{{
  nnoremap <silent><buffer><expr>d unite#do_action('delete')
  nnoremap <silent><buffer><expr>D unite#do_action('delete_force')
  nnoremap <silent><buffer><expr>rd unite#do_action('delete_remote')
  nnoremap <silent><buffer><expr>rD unite#do_action('delete_remote_force')
endfunction"}}}

function! s:unite_hooks.giti_branch_all() "{{{
  call self.giti_branch()
endfunction"}}}
"}}}
