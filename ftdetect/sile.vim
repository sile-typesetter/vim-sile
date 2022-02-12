" Per https://github.com/sile-typesetter/vim-sile/issues/7, note the more
" traditional 'nice' method of using :setfiletype instead of :set filetype
" will not work here because upstream VIM takes over the *.sil extension for
" Swift Intermedite Language, see:
" https://github.com/vim/vim/commit/0d76683e094c6cac2e879601aff3acf1163cbe0b
"
" vint: -ProhibitAutocmdWithNoGroup
autocmd BufNewFile,BufRead *.sil set filetype=sile
