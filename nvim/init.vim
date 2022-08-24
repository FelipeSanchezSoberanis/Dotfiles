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

" Move in snippets with tab
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

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

" Toggle nerdtree
nnoremap <leader>nt :NERDTreeToggle<CR>:NERDTreeRefreshRoot<CR>

" Trim trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" Search filename in working directory
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>a<C-p> :Files<CR>
nnoremap <C-f> :Ag<CR>

" Select pasted text
nnoremap <expr> <leader>sp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Search selected text
vnoremap <leader>ss y/\V<C-r>=escape(@",'/\')<CR><CR>

" Search text from clipboard
nnoremap <leader>ss /\V<C-r>=escape(@*,'/\')<CR><CR>

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

" Bookmarks
nnoremap mn <Plug>BookmarkNext
nnoremap mN <Plug>BookmarkPrev
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1

augroup remember_folds
  autocmd!
  autocmd BufWinLeave * silent! mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" " Jdtls mappings only for java
" autocmd FileType java nnoremap <buffer> <leader>cao <Cmd>lua require'jdtls'.organize_imports()<CR>
" autocmd FileType java nnoremap <buffer> <leader>caev <Cmd>lua require('jdtls').extract_variable()<CR>
" autocmd FileType java vnoremap <buffer> <leader>caev <Cmd>lua require('jdtls').extract_variable(true)<CR>
" autocmd FileType java nnoremap <buffer> <leader>caec <Cmd>lua require('jdtls').extract_constant()<CR>
" autocmd FileType java vnoremap <buffer> <leader>caec <Cmd>lua require('jdtls').extract_constant(true)<CR>
" autocmd FileType java vnoremap <buffer> <leader>caem <Cmd>lua require('jdtls').extract_method(true)<CR>

" Toggle word wrapping
nnoremap <leader>ww :set wrap!<CR>

" Formatters on save
source /home/felipe/.config/nvim/formattersonsave.vim

" File indents
source /home/felipe/.config/nvim/fileindents.vim

lua << EOF
package.path = package.path .. ';/home/felipe/.config/nvim/?.lua'

require('gitsignsconfig')
require('treesitterconfig')
require('nvimlspconfig')
require('indentblanklineconfig')
require('treesittercontextconfig')
EOF
