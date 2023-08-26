" Set configs
source /home/felipe/.config/nvim/setConfigs.vim

" Plugins
source /home/felipe/.config/nvim/plugins.vim

" Formatters
source /home/felipe/.config/nvim/formattersConfig.vim

" Transparent background
highlight Normal guibg=none
highlight NonText guibg=none

" Space as leader
let mapleader=" "
nnoremap <SPACE> <Nop>

" Center after page movement
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" NerdCommenter
let g:NERDSpaceDelims = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Python provider
let g:python3_host_prog = "python"

" Airline
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers

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

" FZF but only search from the current directory down
command! -bang -nargs=? GFilesCwd
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(<q-args> == '?' ? { 'dir': getcwd(), 'placeholder': '' } : { 'dir': getcwd() }), <bang>0)

" Search filename in working directory
" nnoremap <C-p> :GFiles<CR>
nnoremap <C-p> :GFilesCwd<CR>
nnoremap <leader>a<C-p> :Files<CR>
nnoremap <C-f> :Ag<CR>

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

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" Move between buffers
nnoremap <leader>nb :bnext<CR>
nnoremap <leader>pb :bprevious<CR>

" augroup remember_folds
"   autocmd!
"   autocmd BufWinLeave * silent! mkview
"   autocmd BufWinEnter * silent! loadview
" augroup END

" Toggle word wrapping
nnoremap <leader>ww :set wrap!<CR>

" Toggle word wrapping
autocmd FileType markdown nnoremap <buffer> <leader>toc :Toc<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

lua << EOF
package.path = package.path .. ';/home/felipe/.config/nvim/?.lua'

require('gitSignsConfig')
require('treeSitterConfig')
require('treeSitterContextConfig')
require('indentBlankLinesConfig')
require('nvimLspConfig')
require('catppuccinConfig')
require('troubleConfig')
EOF

" Set colors
highlight CursorLine guibg=#403E3A
highlight LineNr guifg=#7f849c
highlight CursorLineNr guifg=#a6adc8

" Catpuccin for vim airline
let g:airline_theme = 'catppuccin'

