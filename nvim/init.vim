set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set exrc
set nowrap
set relativenumber
set hidden
set noerrorbells
set nu
set scrolloff=10
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set signcolumn=yes
set colorcolumn=80
set numberwidth=1
set mouse=a
set encoding=UTF-8
set cursorline
set completeopt=menu,menuone
set nrformats+=alpha
set diffopt+=vertical
set linebreak
set iskeyword-=_
set foldmethod=syntax
set nofoldenable

call plug#begin('~/.nvim/plugged')

Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

" Dracula as colorscheme
colorscheme dracula
highlight Normal guibg=None

" Space as leader
let mapleader=" "
nnoremap <SPACE> <Nop>

" NerdCommenter
let g:NERDSpaceDelims = 1

lua << EOF
package.path = package.path .. ';/home/felipe/.config/nvim/?.lua'

require('gitsignsconfig')
require('treesitterconfig')
EOF
