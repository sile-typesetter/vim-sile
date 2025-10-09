" SPDX-FileCopyrightText: © 2015 Caleb Maclennan <caleb@alerque.com>
" SPDX-License-Identifier: GPL-2.0-or-later

scriptencoding utf-8

call sile#init()

if exists('b:did_ftplugin')
  finish
endif

let b:did_ftplugin = 1

setlocal comments=:%
setlocal commentstring=%\ %s
