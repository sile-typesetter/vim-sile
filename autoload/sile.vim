" SPDX-FileCopyrightText: © 2015 Caleb Maclennan <caleb@alerque.com>
" SPDX-License-Identifier: GPL-2.0-or-later

scriptencoding utf-8

if exists('g:loaded_sile')
  finish
endif

let g:loaded_sile = 1

if exists('g:sile_no_bin') && g:sile_no_bin
  unlet! g:sile_bin
elseif !exists('g:sile_bin') || empty(g:sile_bin)
  if executable('sile')
    let g:sile_bin = 'sile'
  else
    unlet! g:sile_bin
    echohl WarningMsg
    echomsg 'No sile command detected, set g:sile_bin to enable more vim-sile features.'
    echohl None
  endif
elseif !executable(g:sile_bin)
  unlet! g:sile_bin
  echohl WarningMsg
  echomsg 'Command set in g:sile_bin is not executable, fix to to enable more vim-sile features.'
  echohl None
endif

if !exists('g:sile_main')
  let g:sile_main = '%:p'
endif

function! sile#init() abort
  if !exists('b:sile_bin')
    let b:sile_bin = get(g:, 'sile_bin', 0)
  endif
  let settings = [
        \ 'sile_main',
        \ ]
  for setting in settings
    if !has_key(b:, setting)
      let b:{setting} = get(g:, setting)
    endif
  endfor
endfunction
