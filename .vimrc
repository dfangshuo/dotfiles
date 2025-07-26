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

set cursorline
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

" tab settings
set tabstop=4
set shiftwidth=4
set expandtab

" Inspired by https://github.com/umutgultepe/vimconfig/blob/master/.vimrc
"
" http://stackoverflow.com/questions/1551231/highlight-variable-under-cursor-in-vim-like-in-netbeans
:autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))

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

" Attempt at autoloading the matchit plugin
" runtime macros/matchit.vim

" https://github.com/junegunn/vim-plug
" call plug#begin('~/.vim/plugged')
" 
" Plug 'morhetz/gruvbox'
" Plug 'vim-utils/vim-man'
" " Plug 'git@github.com:kien/ctrlp.vim.git'
" " Plug 'git@github.com:Valloric/YouCompleteMe.git'
" Plug 'git@github.com:tpope/vim-commentary.git'
" Plug 'mbbill/undotree'
" Plug 'vim-airline/vim-airline'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" " Plug 'tmhedberg/matchit'
" Plug 'andymass/vim-matchup'
" Plug 'tpope/vim-surround'
" 
" 
" call plug#end()

set runtimepath^=~/.vim/bundle/ctrlp.vim


" colorscheme gruvbox
" set background=dark

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
  let wordUnderCursor = expand("<cword>")
  let @+ = "from " . path . "." . module . " import " . wordUnderCursor
endfunction

" Deprecated, since we moved away from Phabricator
" function! CopyPhabLink()
"   let lineNumber = line(".")
"   let filename = @%
"   let root = "https://abnormal.phacility.com/diffusion/1/browse/master/"
"   let @+ = root . filename . "$" . lineNumber
" endfunction
" nnoremap <leader>yp :call CopyPhabLink()<CR>

" Deprecated, using GitLinks which is more robust
"Github Link
" function! CopyGitLink()
"   let lineNumber = line(".")
"   let filename = @%
"   let splitFilename = split(filename, "/")[3:]
"   let filename = join(splitFilename, "/")
"   let root = "https://github.com/abnormal-security/source/tree/main/"
"   let @+ = root . filename . "#L" . lineNumber
"   echo "Copied URL into clipboard"
" endfunction

" Custom functions
nnoremap <leader>i :call CopyImportStatement() <CR>:q<CR>
nnoremap <leader>I :call CopyImportModuleStatement()<CR>:q<CR>
nnoremap <leader>yg :call CopyGitLink()<CR>

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
" map <C-e> :rightb :vert ter<CR> " This shortcuts conflicts with scrolling down
map <C-t> :tabnew<CR>
" map <Tab> :tabn<CR>
" map <S-Tab> :tabp<CR>

""" LEADER KEYS
"
" e prefix is for user defined (my) functions

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
nnoremap <leader>fc :noh<CR>

" Comment
map <leader>/ gcc

" Copy to clipboard
map <leader>y "*y
map <leader>Y "*Y
map <leader>dd "*dd
map <leader>cc "*cc
" map <leader>yy "*yy
" map <leader>y "*y<CR>

map <leader>pc "*p

" Convert a line of the from /User/.../abnormal/... to from abnormal... import
" nnoremap <leader>ei :s/\//./g<CR>^ctafrom <ESC>A <ESC>dF.aimport <ESC>^v$"*ycc<ESC>

" Convert a line of the from abnormal.module... to from abnormal... import
nnoremap <leader>ei ?abnormal<CR>Ifrom <ESC>$F.s import <ESC>^v$"*ycc<ESC>cc<ESC>

nnoremap <leader>eyd :%s/  /    /g<CR>gg<S-v>G"*d:q!<CR>

" Add "/( to the ends of the current word
nnoremap <leader>" vawoI"<ESC>ea"<ESC>
nnoremap <leader>( vawoI(<ESC>ea)<ESC>

" Copy all page and clear screen
map <leader>eyA gg<S-v>G"*d
map <leader>eya gg<S-v>G"*d:q!<CR>

" FZF
nmap <leader>pp :FZF<CR>

" Swap : and , 
" nnoremap : ,
" nnoremap , :

" j, k Store relative line number jumps in the jumplist.
" nnoremap <expr> k (v:count > 2 ? "m'" . v:count : "") . 'k'
" nnoremap <expr> j (v:count > 2 ? "m'" . v:count : "") . 'j'

" Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <ESC>:m .+1<CR>==
inoremap <C-k> <ESC>:m .-2<CR>==
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==

" Yank import of a file to clipboard
" nnoremap <leader>eci mx*ggn"*yy`xzz<CR>
nnoremap <leader>eci mx*ggn?import <CR>V%"*y`xzz<CR>

"""
" Remapping some useful commands to easier to reach keys
nnoremap <leader>r @
nnoremap <leader>era 2222@

" https://github.com/nelstrom/vim-visual-star-search
" From http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html

" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" recursively vimgrep for word under cursor or selection if you hit leader-star
if maparg('<leader>*', 'n') == ''
  nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
endif
if maparg('<leader>*', 'v') == ''
  vmap <leader>* :<C-u>call <SID>VSetSearch()<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>
endif

" Remap VIM 0 to first non-blank character
nnoremap 0 ^
nnoremap ^ 0


nnoremap Y y$


" nnoremap <leader>g `

" custom jump logic

" " Jump to the first function (Python)
" nnoremap <leader>gtf ?defzz
" nnoremap <leader>gtc ?classzz

" custom jump logic with better UX
nnoremap <leader>ga `Azz
nnoremap <leader>gb `Bzz
nnoremap <leader>gc `Czz
nnoremap <leader>gd `Dzz
nnoremap <leader>ge `Ezz
nnoremap <leader>gf `Fzz
nnoremap <leader>gg `Gzz
nnoremap <leader>gh `Hzz
nnoremap <leader>gi `Izz
nnoremap <leader>gj `Jzz
nnoremap <leader>gk `Kzz
nnoremap <leader>gl `Lzz
nnoremap <leader>gm `Mzz
nnoremap <leader>gn `Nzz
nnoremap <leader>go `Ozz
nnoremap <leader>gp `Pzz
nnoremap <leader>gq `Qzz
nnoremap <leader>gr `Rzz
nnoremap <leader>gs `Szz
nnoremap <leader>gt `Tzz
nnoremap <leader>gu `Uzz
nnoremap <leader>gv `Vzz
nnoremap <leader>gw `Wzz
nnoremap <leader>gx `Xzz
nnoremap <leader>gy `Yzz
nnoremap <leader>gz `Zzz
