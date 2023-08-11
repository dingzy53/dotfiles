if !isdirectory($HOME . '/.vim/vim_undo')
    call mkdir($HOME . '/.vim/vim_undo', 'p')
endif

if !isdirectory($HOME . '/.vim/back')
    call mkdir($HOME . '/.vim/back', 'p')
endif

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot' " syntax
Plug 'gcmt/wildfire.vim'
Plug 'godlygeek/tabular' " text alignment
Plug 'tpope/vim-surround'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for':['markdown', 'vim-plug']}
Plug 'lilydjwg/colorizer'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
call plug#end()

set nopaste
"leader key
let mapleader = ','
let g:mapleader = ','

set background=dark
" base
set termguicolors
syntax on

" theme
set t_Co=16
let g:onedark_termcolors=16
let g:airline_theme='onedark'
colorscheme onedark

"filetype
filetype on
filetype plugin on
filetype indent on

"backup
set history=2000
set undofile
set undodir=$HOME/.vim/vim_undo "path
set backup
set backupdir=$HOME/.vim/back/
set writebackup
set backupcopy=yes
set updatetime=100

set autoread
set shortmess=atI "no banner
set magic
set title
set novisualbell
set noerrorbells
set visualbell t_vb=
set t_vb= "visualbell ouput = none
set tm=500

set nofoldenable

"move
set cursorcolumn
set scrolloff=18

" show
set cursorline
set ruler
set tw=74
set number
set relativenumber
set wrap
set showcmd
set showmode
set showmatch
set matchtime=2

"search
set incsearch
set ignorecase
set smartcase

" tab
set expandtab "convert tab to space
set smarttab
set shiftround

" indent
set autoindent smartindent
set shiftwidth=4
set tabstop=4
set softtabstop=4

" encoding
set encoding=utf-8

"disable wrap
set formatoptions-=t
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
" 跳转回上次的位置
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" set mark column color
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

set list
set listchars=tab:>·,trail:·
highlight MyTabSpace guifg=darkgrey ctermfg=darkgrey

" ============================ specific file type ===========================

autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufRead,BufNew *.md,*.mkd,*.markdown  set filetype=markdown.mkd

" Automatically remove trailing whitespaces on save
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" ============================ key map ============================

nnoremap ; :
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

nnoremap <leader>wq :wq<CR>
noremap <leader>q :q!<CR>
nnoremap <leader>w :w<CR>

" select all
map <Leader>sa ggVG"

" remap U to <C-r> for easier redo
nnoremap U <C-r>

nnoremap ' `
nnoremap ` '

" Keep search pattern at the center of the screen.
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

" H and L to Home and End
nnoremap H ^
nnoremap L $

"inoremap ( ()<ESC>i
"inoremap ' ''<ESC>i
"inoremap " ""<ESC>i
"inoremap { {}<ESC>i
"
"inoremap <Leader><Space> <ESC>o
"inoremap <Leader>a <ESC>A
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
autocmd Filetype markdown nmap <silent> <F9> <Plug>StopMarkdownPreview
autocmd Filetype markdown nnoremap ,t <CR>:TableModeEnable<CR>

""let g:vimtex_view_general_viewer = 'Zathura'
let g:vimtex_view_general_viewer = 'okular'

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
