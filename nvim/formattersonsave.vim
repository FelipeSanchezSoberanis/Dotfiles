" ================================= Formatters =================================
autocmd BufWritePost *.lua silent !lua-format -i %
autocmd BufWritePost *.py silent !black %
autocmd BufWritePost *.vue,*.js,*.java,*.css,*.ts,*.html,*.yaml silent !prettier -w %
autocmd BufWritePost *.cds silent !format-cds -f %

" ================================== Linters ==================================
autocmd BufWritePost *.cds !cds lint %
