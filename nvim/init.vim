" Set configs
source /home/felipe/.config/nvim/setconfig.vim

" List of plugins with vim plug
source /home/felipe/.config/nvim/plugins.vim

" Dracula as colorscheme
colorscheme dracula
highlight Normal guibg=None

" Space as leader
let mapleader=" "
nnoremap <SPACE> <Nop>

" NerdCommenter
let g:NERDSpaceDelims = 1

" Python provider
let g:python3_host_prog = "python"

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

" Move between buffers
nnoremap <leader>nb :bnext<CR>
nnoremap <leader>pb :bprevious<CR>

" Jdtls mappings
nnoremap <leader>cao <Cmd>lua require'jdtls'.organize_imports()<CR>
nnoremap <leader>caev <Cmd>lua require('jdtls').extract_variable()<CR>
vnoremap <leader>caev <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
nnoremap <leader>caec <Cmd>lua require('jdtls').extract_constant()<CR>
vnoremap <leader>caec <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
vnoremap <leader>caem <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>

" Formatters on save
source /home/felipe/.config/nvim/formattersonsave.vim

lua << EOF
package.path = package.path .. ';/home/felipe/.config/nvim/?.lua'

require('gitsignsconfig')
require('treesitterconfig')
require('nvimlspconfig')
require('indentblanklineconfig')
EOF
