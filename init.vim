let mapleader=" "

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'      " Envolver texto con símbolos
Plug 'junegunn/vim-easy-align' " Alinear en símbolo

call plug#end()

filetype plugin on

" Ignorar líneas que den la vuelta al moverse con j y k
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

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

" Cambiar lenguaje
nnoremap <leader>l <Cmd>call VSCodeNotify('workbench.action.editor.changeLanguageMode')<CR>

" Show hover
nnoremap <leader>sh <Cmd>call VSCodeNotify('editor.action.showHover')<CR>

" Math preview Latex
nnoremap <leader>mp <Cmd>call VSCodeNotify('latex-workshop.openMathPreviewPanel')<CR>
