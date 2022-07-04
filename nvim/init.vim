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

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
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

" Airline
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#branch#enabled = 1

" Toggle nerdtree
nnoremap <leader>nt :NERDTreeToggle<CR>

" Trim trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" Search filename in working directory
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>a<C-p> :Files<CR>
nnoremap <C-f> :Ag<CR>


" Select pasted text
nnoremap <expr> <leader>sp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Search selected text
vnoremap <leader>ss y/\V<C-r>"<CR>

" Change conceal level
nnoremap <leader>cl1 :set conceallevel=1<CR>
nnoremap <leader>cl0 :set conceallevel=0<CR>

" Find TODOs
nnoremap <leader>ft /\VTODO<CR>

" Find placeholders
nnoremap <leader>fp /\V<++><CR>

" Center after search
nnoremap n nzz
nnoremap N Nzz

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

lua << EOF
package.path = package.path .. ';/home/felipe/.config/nvim/?.lua'

require('gitsignsconfig')
require('treesitterconfig')
EOF
