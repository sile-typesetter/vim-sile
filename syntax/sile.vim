" Vim syntax file
" Language:   SILE
" Maintainer: Caleb Maclennan <caleb@alerque.com>
" URL:        https://github.com/sile-typesetter/vim-sile

scriptencoding utf-8

if exists('b:current_syntax')
  finish
endif

syntax clear

unlet! b:current_syntax
syntax include @XML syntax/xml.vim

unlet! b:current_syntax
syntax include @LUA syntax/lua.vim

syntax spell toplevel

syntax sync maxlines=200
syntax sync minlines=50

syntax case ignore
syntax keyword sileTodo		contained fixme todo xxx
syntax case match
syntax keyword sileBoolean	contained true false

syntax match sileComment	"%.*$"			contains=@Spell,sileTodo
syntax match sileEscapedChar	"\\[\\%{}]"
syntax match sileCommand	"\\\h[a-zA-Z0-9:-]\+"	nextgroup=sileOptions,sileContents
syntax match sileBlock		"\\begin\>\|\\end\>"	nextgroup=sileBlockOptions,sileBlockCommand
syntax match sileLua		"\\\(script\|lua\)\>"	nextgroup=sileOptions,sileInlineLua
syntax match sileXml		"\\xml\>"		nextgroup=sileOptions,sileInlineXml

syntax match sileOption		"\h[a-zA-Z0-9-]\+"	contained nextgroup=sileOptionDef
syntax match sileOptionDef	"="			contained nextgroup=sileOptionQuoted,sileOptionVal
syntax match sileOptionVal	'[^,\]"]\+'		contained contains=sileBoolean nextgroup=sileOptionSep
syntax match sileOptionSep	","			contained

syntax region sileBlockLua	start="\\begin\(\[[^\]]*]\)\={script}" end="\\end{script}"me=s-1 keepend contains=@LUA,sileBlock
syntax region sileBlockLua	start="\\begin\(\[[^\]]*]\)\={lua}" end="\\end{lua}"me=s-1 keepend contains=@LUA,sileBlock
syntax region sileBlockXml	start="\\begin\(\[[^\]]*]\)\={xml}" end="\\end{xml}"me=s-1 keepend contains=@XML,sileBlock

syntax region sileContents	matchgroup=Delimiter start="{"	skip="\\}" end="}" keepend contained contains=TOP
syntax region sileOptions	matchgroup=Delimiter start="\["	end="]" keepend contained contains=sileOption nextgroup=sileContents
syntax region sileBlockOptions	matchgroup=Delimiter start="\["	end="]" keepend contained contains=sileOption nextgroup=sileBlockCommand
syntax region sileInlineLua	matchgroup=Delimiter start="{"	end="}" contained contains=@LUA
syntax region sileInlineXml	matchgroup=Delimiter start="{"	end="}" contained contains=@XML
syntax region sileBlockCommand	matchgroup=Delimiter start="{"	end="}" keepend contained contains=sileContents
syntax region sileOptionQuoted	matchgroup=Delimiter start='"'	skip='\\"' end='"' contained keepend contains=sileBoolean

highlight! def link sileComment		Comment
highlight! def link sileTodo		Todo
highlight! def link sileBoolean		Boolean
highlight! def link sileEscapedChar	Special
highlight! def link sileCommand		Function
highlight! def link sileLua		Type
highlight! def link sileXml		Type
highlight! def link sileOption		Identifier
highlight! def link sileOptionVal	Character
highlight! def link sileOptionSep	Delimiter
highlight! def link sileOptionDef	Operator
highlight! def link sileOptionVal	Character
highlight! def link sileOptionQuoted	String
highlight! def link sileBlock		Repeat
highlight! def link sileBlockCommand	Function

let b:current_syntax = 'sile'
" vim: ts=8 fdm=marker
