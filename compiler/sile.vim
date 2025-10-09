" SPDX-FileCopyrightText: © 2015 Caleb Maclennan <caleb@alerque.com>
" SPDX-License-Identifier: GPL-2.0-or-later

scriptencoding utf-8

if exists('b:current_compiler')
  finish
endif

call sile#init()

let b:current_compiler = b:sile_bin

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:escaped_bin = substitute(b:sile_bin, ' ', '\\ ', 'g')
let s:escaped_main = substitute(shellescape(expand(b:sile_main)), ' ', '\\ ', 'g')

execute 'CompilerSet makeprg=' . s:escaped_bin . '\ ' . s:escaped_main
