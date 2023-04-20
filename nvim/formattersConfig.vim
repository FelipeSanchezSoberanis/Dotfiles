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

function FormatBlack()
    :w
    :silent !black %
endfunction

function FormatClang()
    :w
    :silent !clang-format -style="{IndentWidth: 4}" -i %
endfunction

" Lua formatter
autocmd FileType lua nnoremap <buffer> <leader>ff :call FormatLua() <CR>

" Java formatters
autocmd BufRead,BufNewFile *.java nnoremap <buffer> <leader>ff :call FormatGoogleJavaFormat() <CR>
autocmd BufRead,BufNewFile ~/Documents/projects/erp-matrices/backend/*.java nnoremap <buffer> <leader>ff :call FormatPrettier() <CR>

" Python formatter
autocmd FileType python nnoremap <buffer> <leader>ff :call FormatBlack() <CR>

" Prettier formatter
autocmd FileType vue,typescript,json nnoremap <buffer> <leader>ff :call FormatPrettier() <CR>

" Arduino formatter
autocmd FileType arduino nnoremap <buffer> <leader>ff :call FormatClang() <CR>

