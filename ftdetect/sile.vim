autocmd BufNewFile,BufRead *.sil
      \ if &ft =~# '^\%(conf\|modula2\)$' |
      \   set ft=sile |
      \ else |
      \   setf sile |
      \ endif
