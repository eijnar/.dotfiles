set hidden
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set showmatch
set ignorecase
set smartcase
set smarttab
set incsearch

set history=1000
set undolevels=1000

syntax on
filetype plugin indent on
call plug#begin()
Plug 'arcticicestudio/nord-vim'
call plug#end()
colorscheme nord
