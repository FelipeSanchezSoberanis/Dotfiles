autocmd BufWritePost *.lua silent !lua-format -i %
autocmd BufWritePost *.py silent !black %
autocmd BufWritePost *.vue,*.js,*.java,*.css,*.ts,*.html silent !prettier -w %
