" ================================= Formatters =================================
autocmd BufWritePost *.lua silent !lua-format -i %
autocmd BufWritePost *.py silent !black %
autocmd BufWritePost *.vue,*.js,*.java,*.css,*.scss,*.ts,*.html,*.yaml,*.xml,*.xsl,*.json silent !prettier -w %
autocmd BufWritePost *.cds silent !format-cds -f %
autocmd BufWritePost *.sql silent !sql-formatter % -o %

" ================================== Linters ==================================
autocmd BufWritePost *.cds !cds lint %

" ============================= File indentations =============================
autocmd FileType xml setlocal shiftwidth=2
autocmd FileType xml setlocal tabstop=2
autocmd FileType xml setlocal softtabstop=2

autocmd FileType xslt setlocal shiftwidth=2
autocmd FileType xslt setlocal tabstop=2
autocmd FileType xslt setlocal softtabstop=2

autocmd FileType css setlocal shiftwidth=2
autocmd FileType css setlocal tabstop=2
autocmd FileType css setlocal softtabstop=2

autocmd FileType json setlocal shiftwidth=2
autocmd FileType json setlocal tabstop=2
autocmd FileType json setlocal softtabstop=2

autocmd FileType scss setlocal shiftwidth=2
autocmd FileType scss setlocal tabstop=2
autocmd FileType scss setlocal softtabstop=2
