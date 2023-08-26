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
set cursorline
set completeopt=menu,menuone
set nrformats+=alpha
set diffopt+=vertical
set linebreak
set iskeyword-=_
set iskeyword-=-
set splitbelow
set splitright
set ignorecase
set smartcase
set cursorline
syntax off

" Transparent background
highlight Normal guibg=none
highlight NonText guibg=none

" Set cursorline color
autocmd WinEnter * highlight CursorLine guibg=#403E3A

" Space as leader
let mapleader=" "
nnoremap <SPACE> <Nop>

" Center after page movement
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" Active nvim registers with clipboard
let g:clipboard = {
  \   'name': 'xclip-xfce4-clipman',
  \   'copy': {
  \      '+': 'xclip -selection clipboard',
  \      '*': 'xclip -selection clipboard',
  \    },
  \   'paste': {
  \      '+': 'xclip -selection clipboard -o',
  \      '*': 'xclip -selection clipboard -o',
  \   },
  \   'cache_enabled': 1,
  \ }

" Trim trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" Select pasted text
nnoremap <expr> <leader>sp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Search selected text
vnoremap <leader>ss y/\V<C-r>=escape(@",'/\')<CR><CR>

" Search text from clipboard
nnoremap <leader>ss /\V<C-r>=escape(@*,'/\')<CR><CR>

" Find TODOs
nnoremap <leader>ft /\VTODO<CR>

" Find placeholders
nnoremap <leader>fp /\V<++><CR>

" Copy with keyboard on visual mode
vnoremap <C-c> "+y

" Center after search
nnoremap n nzz
nnoremap N Nzz

" Center after par skip
nnoremap { {zz
nnoremap } }zz

" Move between buffers
nnoremap <leader>nb :bnext<CR>
nnoremap <leader>pb :bprevious<CR>

" Toggle word wrapping
nnoremap <leader>ww :set wrap!<CR>

