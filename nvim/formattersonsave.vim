" ================================= Formatters =================================
autocmd BufWritePost *.lua silent !lua-format -i %
autocmd BufWritePost *.py silent !black %
autocmd BufWritePost *.vue,*.js,*.java,*.css,*.scss,*.ts,*.html,*.yaml,*.xml,*.xsl,*.json,*.cjs silent !prettier -w %
autocmd BufWritePost *.cds silent !format-cds -f %
autocmd BufWritePost *.sql silent !sql-formatter % -o %

" ================================== Linters ==================================
autocmd BufWritePost *.cds !cds lint %

" ============================= File indentations =============================
