" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

syntax on
set noerrorbells
set expandtab
set smartindent
set nowrap
set noswapfile
set incsearch

set number
set relativenumber
set ruler
set showcmd
" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Disable the default Vim startup message.
set shortmess+=I

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Highlight all instances of a selected word
set hlsearch

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>
" nnoremap zz I/* <ESC>A */<ESC>
" set scrolloff=999
" let g:ctrlp_map = '<c-p>'

" CtrlP
" let g:ctrlp_map = '<leader>pp'
" let g:ctrlp_cmd = 'CtrlP'


set autoindent
filetype plugin indent on

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'vim-utils/vim-man'
" Plug 'git@github.com:kien/ctrlp.vim.git'
" Plug 'git@github.com:Valloric/YouCompleteMe.git'
Plug 'git@github.com:tpope/vim-commentary.git'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

set runtimepath^=~/.vim/bundle/ctrlp.vim


colorscheme gruvbox
set background=dark

let g:ctrlp_use_caching=0
let g:netrw_winsize=25

" ===========================================================
" ===========================================================

" Functions

function! CopyImportStatement()
  let filename = @%
  let pieces = split(filename, "/")
  let module = substitute(pieces[-1], ".py", "", "g")
  let path = join(pieces[2:-2], ".")
  let @+ = "from " . path . " import " . module
endfunction

function! CopyImportModuleStatement()
  let filename = @%
  let pieces = split(filename, "/")
  let module = substitute(pieces[-1], ".py", "", "g")
  let path = join(pieces[2:-2], ".")
  let @+ = "from " . path . "." . module . " import "
endfunction

function! CopyPhabLink()
  let lineNumber = line(".")
  let filename = @%
  let root = "https://abnormal.phacility.com/diffusion/1/browse/master/"
  let @+ = root . filename . "$" . lineNumber
endfunction

function! PytestCommand()
  let filename = @%
  let pieces = split(filename, "/")
  let relativeName = join(pieces[2:-1], "/")
  echo relativeName
  let @+ = "run_pytests --skip-airflow-db --nomigrations " . relativeName
endfunction

" ===========================================================
" ===========================================================

" Ctrl Key Shortcuts
map <C-e> :rightb :vert ter<CR>
map <C-t> :tabnew<CR>
" map <Tab> :tabn<CR>
" map <S-Tab> :tabp<CR>

" Set Leader Key
map <Space> <Leader>

""" Leader Key shortcuts
map <leader>j :rightb :vert ter<CR>

" Windows
map <leader>wL :vsplit<CR>
map <leader>wl :wincmd w<CR>
map <leader>wh :wincmd p<CR>
map <leader>sd :Vex<CR>

" Tabs
" map <leader>t :tabnew<CR>
" map <leader>n :tabn<CR>
" map <leader>N :tabp<CR>
map <leader>tn :tabnew<CR>
map <leader><Tab> :tabn<CR>
map <leader><S-Tab> :tabp<CR>

map <leader>q :q<CR>
map <leader>Qy :q!<CR>
map <leader>s :w<CR>
map <leader>fs :wq<CR>

" Comment
map <leader>/ gcc

" Copy to clipboard
map <leader>yc "*y

" Copy all page and clear screen
map <leader>ya gg<S-v>G"*d
map <leader>yA gg<S-v>G"*d:q!<CR>

" FZF
nmap <leader>pp :FZF<CR>

" map <leader>y "*y<CR>

nnoremap <leader>i :call CopyImportStatement() <CR>:q<CR>
nnoremap <leader>yp :call CopyPhabLink()<CR>
nnoremap <leader>I :call CopyImportModuleStatement()<CR>:q<CR>
