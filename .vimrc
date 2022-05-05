call plug#begin()

Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jaredpar/EasyMotion'
Plug 'godlygeek/tabular'
"Plug 'preservim/nerdtree',{'on':'NERDTreeToggle'}
Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'tpope/vim-surround'
Plug 'gcmt/wildfire.vim'

call plug#end()

"" gvim setting
"set lines=36 columns=80
"" 分割出来的窗口位于当前窗口下边/右边
"set splitbelow
"set splitright
""不显示工具/菜单栏
"set guioptions-=T
"set guioptions-=m
"set guioptions-=L
"set guioptions-=r
"set guioptions-=b
"" 使用内置 tab 样式而不是 gui
"set guioptions-=e
"set nolist
"set guifont=Consolas:h14
" ================================================================================

let mapleader = ','
let g:mapleader = ','

" base
syntax on
filetype on
filetype plugin on
filetype indent on
set history=2000
set undofile
set undodir=$HOME/.vim/vim_undo "path
set nocompatible
set autoread
set shortmess=atI
set magic
set title
set novisualbell
set noerrorbells
set visualbell t_vb=
set t_vb=
set tm=500
set t_Co=256

"move
set cursorcolumn
set scrolloff=18

" show
set cursorline
set ruler
set textwidth=80
set number
set relativenumber
set nowrap
set showcmd
set showmode
set showmatch
set matchtime=2

"search
set incsearch
set ignorecase
set smartcase

" tab
set expandtab
set smarttab
set shiftround

" indent
set autoindent smartindent
set shiftwidth=4
set tabstop=4
set softtabstop=4

" encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=utf-8
set ffs=unix,dos,mac
set formatoptions+=m
set formatoptions+=B

" select & complete
set selection=inclusive
set selectmode=mouse,key
set completeopt=longest,menu
set wildmenu
set wildmode=longest,list,full
set wildignore=*.o,*~,*.pyc,*.class

" others
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" if this not work ,make sure .viminfo is writable for you
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" theme
set background=dark
colorscheme delek
let g:onedark_termcolors=256
let g:airline_theme='onedark'

" set mark column color
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

setlocal list
set listchars=tab:>-,trail:.
highlight MyTabSpace guifg=darkgrey ctermfg=darkgrey
match MyTabSpace /\t\| /


" ============================ specific file type ===========================

autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufRead,BufNew *.md,*.mkd,*.markdown  set filetype=markdown.mkd

autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    " .sh
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    " python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# encoding: utf-8")
    endif

    normal G
    normal o
    normal o
endfunc

autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" ============================ key map ============================

nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
noremap J 5j
noremap K 5k


map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nnoremap <F2> :set nu! nu?<CR>
nnoremap <F3> :set list! list?<CR>
nnoremap <F4> :set wrap! wrap?<CR>

au InsertLeave * set nopaste
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

nnoremap <leader>wq :wq<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>w :w<CR>

" select all
map <Leader>sa ggVG"

" remap U to <C-r> for easier redo
nnoremap U <C-r>

nnoremap ' `
nnoremap ` '

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" remove highlight
noremap <silent><leader>/ :nohls<CR>

"Reselect visual block after indent/outdent.
vnoremap < <gv
vnoremap > >gv

" y$ -> Y Make Y behave like other capitals
map Y y$

nnoremap H ^
nnoremap L $

" Markdown
autocmd Filetype markdown inoremap ,f <Esc>/<++><CR>:nohlsearch<CR>c4l
autocmd Filetype markdown inoremap ,g <++><Enter><Enter>
autocmd Filetype markdown inoremap ,n ---<Enter><Enter>
autocmd Filetype markdown inoremap ,b **** <++><Esc>F*hi
autocmd Filetype markdown inoremap ,s ~~~~ <++><Esc>F~hi
autocmd Filetype markdown inoremap ,i ** <++><Esc>F*i
autocmd Filetype markdown inoremap ,d `` <++><Esc>F`i
autocmd Filetype markdown inoremap ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap ,h ====<Space><++><Esc>F=hi
autocmd Filetype markdown inoremap ,p ![](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap ,a [](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap ,m $<++>$<++><Esc>?<++><CR>:nohlsearch<CR>nc4l
autocmd Filetype markdown inoremap ,q #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,w ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,e ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,r ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,l --------<Enter>
map <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4i
set clipboard=unnamedplus
let g:mkdp_auto_start = 1
let g:mkdp_browser = 'firefox'
autocmd Filetype markdown nmap <silent> <F9> <Plug>StopMarkdownPreview
autocmd Filetype markdown nnoremap ,t <CR>:TableModeEnable<CR>

" python
autocmd Filetype python nnoremap <buffer> <F5> :w<CR>:!python3 %<CR>
autocmd Filetype python nnoremap ,3 ^i#<Space><Esc>
autocmd Filetype python inoremap ,3 ^i#<Space><Esc>

" txt
autocmd Filetype text nnoremap ,d <CR>:g/^\s*$/d<CR>
autocmd Filetype text nnoremap ,a <CR>:%s/\s+$//g<CR>
autocmd Filetype text nnoremap ,g <CR>:%s/./&/g<CR>
