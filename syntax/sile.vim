" Vim syntax file
" Language:     SILE
" Maintainer:   Caleb Maclennan <caleb@alerque.com
" Filenames:    *.sile
" Last Change:  2015-06-18

if exists("b:current_syntax")
  finish
endif

if !exists('main_syntax')
  let main_syntax = 'sile'
endif

let b:current_syntax = "sile"
if main_syntax ==# 'sile'
  unlet main_syntax
endif

" vim:set sw=2:
