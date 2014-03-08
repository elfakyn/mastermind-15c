" Vim syntax file
" Language: HP 15C keycode
" Maintainer: Popescu Mihai-Radu
" Latest Revision: 13 May 2012

if exists("b:current_syntax")
    finish
endif

setlocal iskeyword=@,48-57,_,192-255,(,),=,<,>,94,?,/,:
setlocal iskeyword-=:

syn match line '^\d\d\d'
syn match comment "\(--\||\).*$" contains=todos
syn match labela "LBL\( [A-E]\|\(\.\| \)\d\)"
syn match tests 'TEST \d'

syn keyword other  RTN SF CF x<>y R^ Rv x<>
syn keyword dseisg DSE ISG
syn keyword gotos  GTO GSB
syn keyword conds  x<=y x=0 F?
syn keyword store  STO RCL
syn keyword flows  R/S PSE ENTER
syn keyword clear  SUM REG PRGM PREFIX CLx
syn keyword shiftf f
syn keyword shiftg g
syn keyword todos  contained TODO FIXME XXX NOTE

hi def link labela Repeat
hi def link dseisg Repeat
hi def link other  Conditional
hi def link gotos  Keyword
hi def link conds  Character
hi def link tests  Character
hi def link store  Constant
hi def link flows  Title
hi def link clear  Error
hi def link shiftf Repeat
hi def link shiftg Identifier
hi def link todos  Todo

hi def link line   LineNr
hi def link comment Comment
