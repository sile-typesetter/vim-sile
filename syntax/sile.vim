" Vim syntax file
" Language:   SILE
" Maintainer: Caleb Maclennan <caleb@alerque.com>
" URL:        https://github.com/sile-typesetter/vim-sile

scriptencoding utf-8

if exists('b:current_syntax')
  finish
endif

syntax include @LUA syntax/lua.vim

syn sync maxlines=200
syn sync minlines=50

syn case ignore
syn keyword sileTodo		contained	fixme	todo	xxx
syn case match

syn match sileComment		"%.*$"			contains=sileTodo,@Spell
syn match sileCommand		"\\\h[a-zA-Z0-9:-]\+"	nextgroup=sileParameters,sileContents
syn match sileBlock		"\\begin\>\|\\end\>"	nextgroup=sileBlockParameters,sileBlockCommand
syn match sileEscapedChar	"\\[\\%{}]"
syn match sileScript		"\\script\>"		nextgroup=sileParameters,sileLua

syn match sileParameterDef	"="	contained
syn match sileParameterSep	","	contained

syn region sileLua		matchgroup=Delimiter start="{"	end="}"	contained contains=@LUA
syn region sileBlockCommand	matchgroup=Delimiter start="{"	end="}"	contained contains=sileComment
syn region sileContents		matchgroup=Delimiter start="{"	end="}" contained contains=sileComment,sileCommand,sileBlock,sileEscapedChar,sileScript
syn region sileParameters	matchgroup=Delimiter start="\["	end="]"	contained nextgroup=sileContents contains=sileParameterDef,sileParameterSep,sileParameterQuoted,@NoSpell
syn region sileParameterQuoted	matchgroup=Delimiter start='"'	end='"'	contained contains=sileComment,@NoSpell
syn region sileBlockParameters	matchgroup=Delimiter start="\["	end="]"	contained nextgroup=sileBlockCommand contains=sileParameterDef,sileParameterSep,sileParameterQuoted,sileComment,@NoSpell

hi! def link sileScript			Statement
hi! def link sileCommand		Statement
hi! def link sileBlock			Statement
hi! def link sileBlockCommand		PreCondit
hi! def link sileParameters		Number
hi! def link sileBlockParameters	Number
hi! def link sileParameterDef		Operator
hi! def link sileParameterSep		Delimiter
hi! def link sileParameterQuoted	String
hi! def link sileComment		Comment
hi! def link sileEscapedChar		Special
hi! def link sileTodo	 		Todo
hi! def link sileContents		None

let b:current_syntax = 'sile'
" vim: ts=8 fdm=marker
