augroup VimSile
    autocmd!
augroup END

autocmd VimSile BufNewFile,BufRead *.sil
            \ if &ft =~# '^\%(conf\|modula2\)$' |
            \   set ft=sile |
            \ else |
            \   setf sile |
            \ endif

" vim: set fdm=marker et ts=4 sw=4 sts=4:
