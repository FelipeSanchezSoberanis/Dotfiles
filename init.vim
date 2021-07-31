let mapleader=" "

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround' " Envolver texto con símbolos
Plug 'lervag/vimtex'      " Extras para Latex
Plug 'godlygeek/tabular'  " Alinear texto

call plug#end()

filetype plugin on

" Espacio que no haga nada
nnoremap <SPACE> <Nop>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Mover editores
nnoremap <leader>mr <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>
nnoremap <leader>ml <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
nnoremap <leader>md <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
nnoremap <leader>mu <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>

" Peek definition
nnoremap <leader>pd <Cmd>call VSCodeNotify('editor.action.peekDefinition')<CR>

" Go to definition
nnoremap <leader>gd <Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>

" Cambiar lenguaje
nnoremap <leader>l <Cmd>call VSCodeNotify('workbench.action.editor.changeLanguageMode')<CR>

" Show hover
nnoremap <leader>sh <Cmd>call VSCodeNotify('editor.action.showHover')<CR>

" Math preview Latex
nnoremap <leader>mp <Cmd>call VSCodeNotify('latex-workshop.openMathPreviewPanel')<CR>

" Alinear líneas de código a un caracter
vnoremap <leader>aa :'<,'>Tabularize /

" Quitar el highlight después de buscar
nnoremap <leader>nh :noh<CR>
