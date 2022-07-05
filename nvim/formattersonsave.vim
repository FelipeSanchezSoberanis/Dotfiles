autocmd BufWritePost *.lua silent !lua-format -i %
autocmd BufWritePost *.py silent !black %
