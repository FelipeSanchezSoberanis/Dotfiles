function SetBufferIndent(size)
    exe 'setlocal shiftwidth=' . a:size
    exe 'setlocal tabstop=' . a:size
    exe 'setlocal softtabstop=' . a:size
endfunction

autocmd BufRead,BufNewFile *.json,*.xml,*.xslt,*.css,*.scss,*.ts call SetBufferIndent(2)

