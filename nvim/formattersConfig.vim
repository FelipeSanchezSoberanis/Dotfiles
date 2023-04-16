" Lua formatter
autocmd FileType lua nnoremap <buffer> <leader>ff :w <CR> :silent !lua-format -i % <CR>

" Java formatter
autocmd FileType java nnoremap <buffer> <leader>ff :w <CR> :silent !google-java-format % <CR>

" Python formatter
autocmd FileType python nnoremap <buffer> <leader>ff :w <CR> :silent !black % <CR>

" Prettier formatter
autocmd FileType vue,typescript,json nnoremap <buffer> <leader>ff :w <CR> :silent !prettier -w % <CR>

" Arduino formatter
autocmd FileType arduino nnoremap <buffer> <leader>ff :w <CR> :silent !clang-format -i % <CR>

