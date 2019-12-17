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
syn keyword sileBoolean		contained	true false

syn match sileComment		"%.*$"			contains=sileTodo,@Spell
syn match sileEscapedChar	"\\[\\%{}]"
syn match sileCommand		"\\\h[a-zA-Z0-9:-]\+"	nextgroup=sileOptions,sileContents
syn match sileBlock		"\\begin\>\|\\end\>"	nextgroup=sileBlockOptions,sileBlockCommand
syn match sileScript		"\\script\>"		nextgroup=sileOptions,sileInlineLua

syn match sileOption		"\h[a-zA-Z0-9]\+"	contained nextgroup=sileOptionDef
syn match sileOptionDef		"="			contained nextgroup=sileOptionQuoted,sileOptionVal
syn match sileOptionVal		'[^,\]"]\+'		contained contains=sileBoolean nextgroup=sileOptionSep
syn match sileOptionSep		","			contained

syn region sileContents		matchgroup=Delimiter start="{"	end="}" contained keepend contains=TOP,@Spell
syn region sileOptions		matchgroup=Delimiter start="\["	end="]" contained keepend contains=sileOption,@NoSpell nextgroup=sileContents
syn region sileBlockOptions	matchgroup=Delimiter start="\["	end="]" contained keepend contains=sileOption,@NoSpell nextgroup=sileBlockCommand
syn region sileInlineLua	matchgroup=Delimiter start="{"	end="}" contained contains=@LUA
syn region sileBlockCommand	matchgroup=Delimiter start="{"	end="}" contained keepend contains=sileComment
syn region sileOptionQuoted	matchgroup=Delimiter start='"'	end='"' contained keepend contains=sileBoolean,@NoSpell

hi! def link sileComment		Comment
hi! def link sileTodo	 		Todo
hi! def link sileBoolean		Boolean
hi! def link sileEscapedChar		Special
hi! def link sileCommand		Function
hi! def link sileScript			Type
hi! def link sileOption			Identifier
hi! def link sileOptionVal		Character
hi! def link sileOptionSep		Delimiter
hi! def link sileOptionDef		Operator
hi! def link sileOptionVal		Character
hi! def link sileOptionQuoted		String
hi! def link sileBlock			Repeat
hi! def link sileBlockCommand		Function

let b:current_syntax = 'sile'
" vim: ts=8 fdm=marker
