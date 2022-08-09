" ================================= Formatters =================================
autocmd BufWritePost *.lua silent !lua-format -i %
autocmd BufWritePost *.py silent !black %
autocmd BufWritePost *.vue,*.js,*.java,*.css,*.ts,*.html,*.yaml,*.xml,*.xsl silent !prettier -w %
autocmd BufWritePost *.cds silent !format-cds -f %

" ================================== Linters ==================================
autocmd BufWritePost *.cds !cds lint %

" ============================= File indentations =============================
autocmd FileType xml setlocal shiftwidth=2
autocmd FileType xml setlocal tabstop=2
autocmd FileType xml setlocal softtabstop=2

autocmd FileType xslt setlocal shiftwidth=2
autocmd FileType xslt setlocal tabstop=2
autocmd FileType xslt setlocal softtabstop=2
