" Vim syntax file
" Language:   SILE
" Maintainer: Caleb Maclennan <caleb@alerque.com>
" URL:        https://github.com/sile-typesetter/vim-sile

scriptencoding utf-8

if exists('b:current_syntax')
  " finish
endif

syn sync maxlines=200
syn sync minlines=50

if !exists('g:sile_fold_enabled')
 let g:sile_fold_enabled= 0
elseif g:sile_fold_enabled && !has('folding')
 let g:sile_fold_enabled= 0
 echomsg 'Ignoring g:sile_fold_enabled='.g:sile_fold_enabled.'; need to re-compile vim for +fold support'
endif
if g:sile_fold_enabled && &foldmethod ==# 'manual'
 setl foldmethod=syntax
endif

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
  syn region sileComment	start="^\zs\s*%.*\_s*%"	skip="^\s*%"	end='^\ze\s*[^%]' fold
  syn region sileNoSpell	contained fold		matchgroup=sileComment start="%\s*nospell\s*{"	end="%\s*nospell\s*}"	contains=@sileFoldGroup,@NoSpell
else
  syn match sileComment		"%.*$"			contains=@sileCommentGroup
  syn region sileNoSpell	contained		matchgroup=sileComment start="%\s*nospell\s*{"	end="%\s*nospell\s*}"	contains=@sileFoldGroup,@NoSpell
endif

" Catch all commands
syn match sileStatement	"\\[^\({ ]*"
" Catch delimiters
syn match sileDelimiter		"\\\@<![{}]"
" Catch escaped special characters
syn match sileSpecialCodeChar	"\\[\\%{}]"

syn match  sileBeginEnd		"\\begin\>\|\\end\>" nextgroup=sileBeginEndModifier,sileBeginEndName
syn region sileBeginEndModifier	matchgroup=Delimiter start="\["	end="]"	contained	nextgroup=sileBeginEndName	contains=sileComment,@NoSpell
syn region sileBeginEndName		matchgroup=Delimiter start="{"	end="}"	contained	contains=sileComment

syn match  sileDocType		"\\include\>\|\\script\>\>"	nextgroup=sileBeginEndName,sileDocTypeArgs
syn region sileDocTypeArgs		matchgroup=Delimiter start="\["	end="]" contained	nextgroup=sileBeginEndName	contains=sileComment,@NoSpell

hi def link sileDocType		sileCmdName
hi def link sileDocTypeArgs		sileCmdArgs
hi def link sileBeginEnd		sileCmdName
hi def link sileBeginEndName		sileSection
hi def link sileBeginEndModifier	sileCmdArgs
hi def link sileCmdArgs		Number
hi def link sileCmdName		Statement
hi def link sileComment		Comment
hi def link sileDelimiter		Delimiter
hi def link sileSection		PreCondit
hi def link sileSpecialCodeChar	Special
hi def link sileStatement		Statement
hi def link sileTodo	 		Todo

let b:current_syntax = 'sile'
" vim: ts=8 fdm=marker
