function FormatPrettier()
    :w
    :silent !prettier -w %
endfunction

function FormatGoogleJavaFormat()
    :w
    :silent !google-java-format %
endfunction

function FormatLua()
    :w
    :silent !lua-format -i %
endfunction

function FormatBlack(maxWidth)
    :w
    exe 'silent !black -l ' . a:maxWidth . ' %'
endfunction

function FormatClang()
    :w
    :silent !clang-format --style=Google -i %
endfunction

function FormatRust()
    :w
    :silent !rustfmt %
endfunction

" Lua formatters
autocmd BufRead,BufNewFile *.lua nnoremap <buffer> <leader>ff :call FormatLua() <CR>

" Java formatters
autocmd BufRead,BufNewFile *.java nnoremap <buffer> <leader>ff :call FormatGoogleJavaFormat() <CR>
autocmd BufRead,BufNewFile ~/Documents/projects/erp-matrices/backend/*.java nnoremap <buffer> <leader>ff :call FormatPrettier() <CR>

" Python formatters
autocmd BufRead,BufNewFile *.py nnoremap <buffer> <leader>ff :call FormatBlack(100) <CR>

" Prettier formatters
autocmd BufRead,BufNewFile *.vue,*.ts,*.json,*.html,*.js nnoremap <buffer> <leader>ff :call FormatPrettier() <CR>

" Arduino formatters
autocmd BufRead,BufNewFile *.ino nnoremap <buffer> <leader>ff :call FormatClang() <CR>

" Rust formatters
autocmd BufRead,BufNewFile *.rs nnoremap <buffer> <leader>ff :call FormatRust() <CR>

