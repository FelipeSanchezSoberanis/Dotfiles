" Lua formatter
autocmd FileType lua nnoremap <buffer> <leader>ff :w <CR> :silent !lua-format -i % <CR>

" Java formatter
autocmd FileType java nnoremap <buffer> <leader>ff :w <CR> :silent !google-java-format % <CR>

