let mapleader=" "

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'                          " Tema
Plug 'tpope/vim-surround'                       " Envolver texto con símbolos
Plug 'romainl/vim-cool'                         " Desmarcar búsquedas
Plug 'vim-airline/vim-airline'                  " Barra de estado
Plug 'preservim/nerdtree'                       " Explorador de archivos
Plug 'junegunn/vim-easy-align'                  " Alinear en símbolo
Plug 'preservim/nerdcommenter'                  " Comentar líneas
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletar

call plug#end()

colorscheme gruvbox

set smarttab
set cindent
set tabstop=4
set shiftwidth=4
set expandtab
set noswapfile
set colorcolumn=80
set relativenumber
set number
set scrolloff=10

filetype plugin on

" Ignorar líneas que den la vuelta al moverse con j y k
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Mostrar explorador de archivos con ctrl+b
nnoremap <C-b> :NERDTreeToggle<CR>

" Espacio que no haga nada
nnoremap <SPACE> <Nop>

" Moverse en coc con ctrl+j, ctrl+k e insertar con enter
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Toggle comentario con <leader>cc
map <leader>cc <Plug>NERDCommenterToggle

" Cambiar el map default para que el de arriba funcione
map <leader>xdlol <Plug>NERDCommenterComment

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Coc extensions
let g:coc_global_extensions = ['coc-pairs', 'coc-snippets']

" Delete trailing white spaces
autocmd BufWritePre * :%s/\s\+$//e
