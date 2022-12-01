" Lua formatter
autocmd FileType lua nnoremap <buffer> <leader>ff :w <CR> :silent !lua-format -i % <CR>

