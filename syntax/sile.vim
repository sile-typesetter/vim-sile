" Vim syntax file
" Language:     SILE
" Maintainer:   Caleb Maclennan <caleb@alerque.com
" Filenames:    *.sile
" Last Change:  2015-06-18
" Version:	1
" URL:		https://github.com/alerque/vim-sile

" {{{ Start matter
" Abort if we already have syntax running, otherwise get down to SILE business
if exists('b:current_syntax')
  finish
elseif !exists('main_syntax')
  let main_syntax = 'sile'
endif
if !exists('did_tex_syntax_inits')
  command -nargs=+ HiLink hi def link <args>
else
  command -nargs=+ HiLink hi link <args>
endif
if exists('g:sile_no_error') && g:sile_no_error
 let s:sile_no_error= 1
endif
" }}}

" {{{ Configuration
syn sync maxlines=200
syn sync minlines=50

" by default, enable all region-based highlighting
if exists('g:sile_fast')
 if type(g:sile_fast) != 1
  " g:sile_fast exists and is not a string, so
  " turn off all optional region-based highighting
  let s:sile_fast= ''
 else
  let s:sile_fast= g:sile_fast
 endif
 let s:sile_no_error= 1
else
 let s:sile_fast= 'sm'
endif
" }}}

" {{{ Handle folding
if !exists('g:sile_fold_enabled')
 let g:sile_fold_enabled= 0
elseif g:sile_fold_enabled && !has('folding')
 let g:sile_fold_enabled= 0
 echomsg 'Ignoring g:sile_fold_enabled='.g:sile_fold_enabled.'; need to re-compile vim for +fold support'
endif
if g:sile_fold_enabled && &foldmethod ==# 'manual'
 setl foldmethod=syntax
endif
"}}}

" {{{ Handle Comments
if !exists('g:sile_comment_nospell') || !g:sile_comment_nospell
 syn cluster sileCommentGroup	contains=sileTodo,@Spell
else
 syn cluster sileCommentGroup	contains=sileTodo,@NoSpell
endif
syn case ignore
syn keyword sileTodo		contained		combak	fixme	todo	xxx
syn case match
if g:sile_fold_enabled
  " allows syntax-folding of 2 or more contiguous comment lines
  " single-line comments are not folded
  syn match  sileComment	"%.*$"			contains=@sileCommentGroup
  if s:sile_fast =~# 'c'
  syn region sileComment	start="^\zs\s*%.*\_s*%"	skip="^\s*%"	end='^\ze\s*[^%]' fold
  syn region sileNoSpell	contained fold		matchgroup=sileComment start="%\s*nospell\s*{"	end="%\s*nospell\s*}"	contains=@sileFoldGroup,@NoSpell
  endif
else
  syn match sileComment		"%.*$"			contains=@sileCommentGroup
  if s:sile_fast =~# 'c'
  syn region sileNoSpell	contained		matchgroup=sileComment start="%\s*nospell\s*{"	end="%\s*nospell\s*}"	contains=@sileFoldGroup,@NoSpell
  endif
endif
" }}}

" {{{ Catch all basic syntacx
" Catch all commands
syn match sileStatement	"\\[^\({ ]*"
" Catch delimiters
syn match sileDelimiter		"\\\@<![{}]"
" Catch escaped special characters
syn match sileSpecialCodeChar	"\\[\\%{}]"
" }}}

" {{{ \begin{}/\end{} section markers
syn match  sileBeginEnd		"\\begin\>\|\\end\>" nextgroup=sileBeginEndModifier,sileBeginEndName
if s:sile_fast =~# 'm'
  syn region sileBeginEndModifier	matchgroup=Delimiter start="\["	end="]"	contained	nextgroup=sileBeginEndName	contains=sileComment,@NoSpell
  syn region sileBeginEndName		matchgroup=Delimiter start="{"	end="}"	contained	contains=sileComment
endif
" }}}

" {{{ \include[]/\script[]:
syn match  sileDocType		"\\include\>\|\\script\>\>"	nextgroup=sileBeginEndName,sileDocTypeArgs
if s:sile_fast =~# 'm'
  syn region sileDocTypeArgs		matchgroup=Delimiter start="\["	end="]" contained	nextgroup=sileBeginEndName	contains=sileComment,@NoSpell
endif
" }}}

" {{{ Highlighting
HiLink sileDocType		sileCmdName
HiLink sileDocTypeArgs		sileCmdArgs
HiLink sileBeginEnd		sileCmdName
HiLink sileBeginEndName		sileSection
HiLink sileBeginEndModifier	sileCmdArgs
HiLink sileCmdArgs		Number
HiLink sileCmdName		Statement
HiLink sileComment		Comment
HiLink sileDelimiter		Delimiter
HiLink sileSection		PreCondit
HiLink sileSpecialCodeChar	Special
HiLink sileStatement		Statement
HiLink sileTodo	 		Todo
delcommand HiLink
" }}}

" {{{ End matter
let b:current_syntax = 'sile'
if main_syntax ==# 'sile'
  unlet main_syntax
endif
" }}}
" vim:set sw=2 ts=8 fdm=marker
