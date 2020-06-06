" Tomorrow Night Bright - Full Colour and 256 Colour
" http://chriskempson.com
"
" Hex colour conversion functions borrowed from the theme "Desert256""

" Default GUI Colours
let s:foreground = "d0d0d0"
" let s:foreground = "eaeaea"
let s:background = "282828"
let s:selection  = "424242"
let s:line       = "2a2a2a"
let s:comment    = "969896"
let s:red        = "d54e53"
let s:orange     = "e78c45"
let s:yellow     = "e7c547"
let s:green      = "b9ca4a"
let s:aqua       = "70c0b1"
let s:blue       = "7aa6da"
let s:purple     = "c397d8"
let s:window     = "4d5057"
let s:grey       = "303030"
let s:black      = "000000"

let s:dark_yellow = "c3b622"
let s:grey_37     = "5f5f5f"
let s:grey_237    = "3a3a3a"
let s:grey_238    = "444444"
let s:grey_239    = "4e4e4e"
let s:purple_93   = "8700ff"
let s:red_174     = "e48c8f"

set background=dark
hi clear
syntax reset

let g:colors_name = "Tomorrow-Night-Bright"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
	" Returns an approximate grey index for the given grey level
	fun <SID>grey_number(x)
		if &t_Co == 88
			if a:x < 23
				return 0
			elseif a:x < 69
				return 1
			elseif a:x < 103
				return 2
			elseif a:x < 127
				return 3
			elseif a:x < 150
				return 4
			elseif a:x < 173
				return 5
			elseif a:x < 196
				return 6
			elseif a:x < 219
				return 7
			elseif a:x < 243
				return 8
			else
				return 9
			endif
		else
			if a:x < 14
				return 0
			else
				let l:n = (a:x - 8) / 10
				let l:m = (a:x - 8) % 10
				if l:m < 5
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" Returns the actual grey level represented by the grey index
	fun <SID>grey_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 46
			elseif a:n == 2
				return 92
			elseif a:n == 3
				return 115
			elseif a:n == 4
				return 139
			elseif a:n == 5
				return 162
			elseif a:n == 6
				return 185
			elseif a:n == 7
				return 208
			elseif a:n == 8
				return 231
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 8 + (a:n * 10)
			endif
		endif
	endfun

	" Returns the palette index for the given grey index
	fun <SID>grey_colour(n)
		if &t_Co == 88
			if a:n == 0
				return 16
			elseif a:n == 9
				return 79
			else
				return 79 + a:n
			endif
		else
			if a:n == 0
				return 16
			elseif a:n == 25
				return 231
			else
				return 231 + a:n
			endif
		endif
	endfun

	" Returns an approximate colour index for the given colour level
	fun <SID>rgb_number(x)
		if &t_Co == 88
			if a:x < 69
				return 0
			elseif a:x < 172
				return 1
			elseif a:x < 230
				return 2
			else
				return 3
			endif
		else
			if a:x < 75
				return 0
			else
				let l:n = (a:x - 55) / 40
				let l:m = (a:x - 55) % 40
				if l:m < 20
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" Returns the actual colour level for the given colour index
	fun <SID>rgb_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 139
			elseif a:n == 2
				return 205
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 55 + (a:n * 40)
			endif
		endif
	endfun

	" Returns the palette index for the given R/G/B colour indices
	fun <SID>rgb_colour(x, y, z)
		if &t_Co == 88
			return 16 + (a:x * 16) + (a:y * 4) + a:z
		else
			return 16 + (a:x * 36) + (a:y * 6) + a:z
		endif
	endfun

	" Returns the palette index to approximate the given R/G/B colour levels
	fun <SID>colour(r, g, b)
		" Get the closest grey
		let l:gx = <SID>grey_number(a:r)
		let l:gy = <SID>grey_number(a:g)
		let l:gz = <SID>grey_number(a:b)

		" Get the closest colour
		let l:x = <SID>rgb_number(a:r)
		let l:y = <SID>rgb_number(a:g)
		let l:z = <SID>rgb_number(a:b)

		if l:gx == l:gy && l:gy == l:gz
			" There are two possibilities
			let l:dgr = <SID>grey_level(l:gx) - a:r
			let l:dgg = <SID>grey_level(l:gy) - a:g
			let l:dgb = <SID>grey_level(l:gz) - a:b
			let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
			let l:dr = <SID>rgb_level(l:gx) - a:r
			let l:dg = <SID>rgb_level(l:gy) - a:g
			let l:db = <SID>rgb_level(l:gz) - a:b
			let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
			if l:dgrey < l:drgb
				" Use the grey
				return <SID>grey_colour(l:gx)
			else
				" Use the colour
				return <SID>rgb_colour(l:x, l:y, l:z)
			endif
		else
			" Only one possibility
			return <SID>rgb_colour(l:x, l:y, l:z)
		endif
	endfun

	" Returns the palette index to approximate the 'rrggbb' hex string
	fun <SID>rgb(rgb)
		let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
		let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
		let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

		return <SID>colour(l:r, l:g, l:b)
	endfun

	" Sets the highlighting for the given group
	fun <SID>X(group, fg, bg, attr)
		if a:fg != ""
			exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
		endif
		if a:bg != ""
			exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
		endif
		if a:attr != ""
			exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
		endif
	endfun

	" Vim Highlighting
	call <SID>X("Normal",       s:foreground, s:background,           "")
	call <SID>X("Bold",                   "", "",                 "bold")
	call <SID>X("Debug",               s:red, "",                     "")
	call <SID>X("Directory",          s:blue, "",                     "")
	call <SID>X("Error",        s:background, s:red,                  "")
	call <SID>X("SpellBad",     s:foreground, s:background,  "underline")
	call <SID>X("SpellCap",     s:foreground, s:background,  "underline")
	call <SID>X("Exception",           s:red, "",                     "")
	call <SID>X("FoldColumn",             "", s:background,           "")
	call <SID>X("Folded",          s:comment, s:background,           "")
	call <SID>X("IncSearch",        s:yellow, s:black,                "")
	call <SID>X("Italic",                 "", "",                 "none")
	call <SID>X("Macro",               s:red, "",                 "none")
	call <SID>X("MatchParen",   s:foreground, s:purple_93,            "")
	call <SID>X("ModeMsg",           s:green, "",                     "")
	call <SID>X("MoreMsg",           s:green, "",                     "")
	call <SID>X("Question",           s:blue, "",                     "")
	call <SID>X("Substitute",        s:black, s:yellow,               "")
	call <SID>X("SpecialKey",       s:yellow, "",                     "")
	call <SID>X("LineNr",         s:grey_239, "",                     "")
	call <SID>X("NonText",         s:grey_37, "",                     "")
	call <SID>X("SpecialKey",    s:selection, "",                     "")
	call <SID>X("Search",            s:black, s:dark_yellow,          "")
	call <SID>X("TabLine",      s:foreground, s:background,    "reverse")
	call <SID>X("StatusLine",       s:window, s:yellow,        "reverse")
	call <SID>X("StatusLineNC",     s:window, s:foreground,    "reverse")
	call <SID>X("VertSplit",          s:grey, s:grey,             "none")
	call <SID>X("Visual",                 "", s:selection,            "")
	call <SID>X("WarningMsg",          s:red, "",                     "")
  call <SID>X("CursorLine",             "", s:grey_237,         "none")
  call <SID>X("CursorColumn",           "", s:grey_237,         "none")
  call <SID>X("PMenu",        s:foreground, s:selection,        "none")
  call <SID>X("PMenuSel",     s:foreground, s:selection,     "reverse")
  call <SID>X("SignColumn",             "", s:background,       "none")

	" Standard Highlighting
	call <SID>X("Boolean",       s:orange, "",               "")
	call <SID>X("Character",        s:red, "",               "")
	call <SID>X("Comment",      s:comment, "",               "")
	call <SID>X("Conditional",   s:purple, "",               "")
	call <SID>X("Constant",      s:orange, "",               "")
	call <SID>X("Define",        s:purple, "",           "none")
	call <SID>X("Delimiter",     s:orange, "",               "")
	call <SID>X("Float",         s:orange, "",               "")
	call <SID>X("Function",        s:blue, "",           "bold")
	call <SID>X("Identifier",       s:red, "",           "none")
	call <SID>X("Include",         s:blue, "",               "")
	call <SID>X("Keyword",       s:purple, "",               "")
	call <SID>X("Label",         s:yellow, "",               "")
	call <SID>X("Number",        s:orange, "",               "")
	call <SID>X("Operator",         s:red, "",           "none")
	call <SID>X("PreProc",       s:purple, "",               "")
	call <SID>X("Repeat",        s:purple, "",               "")
	call <SID>X("Special",         s:aqua, "",               "")
	call <SID>X("SpecialChar",     s:aqua, "",               "")
	call <SID>X("Statement",        s:red, "",               "")
	call <SID>X("StorageClass",  s:yellow, "",               "")
	call <SID>X("String",         s:green, "",               "")
	call <SID>X("Structure",     s:purple, "",               "")
	call <SID>X("Tag",           s:yellow, "",               "")
	call <SID>X("Todo",          s:yellow, s:background,     "")
	call <SID>X("Type",          s:yellow, "",           "none")
	call <SID>X("Typedef",       s:yellow, s:grey_237,   "none")
	"call <SID>X("Ignore", "666666", "", "")

  " Diff highlighting
	call <SID>X("diffAdded",         s:green, s:grey_238,     "")
	call <SID>X("diffRemoved",         s:red, s:grey_238,     "")
	call <SID>X("DiffAdd",           s:green, s:grey_238,     "")
	call <SID>X("DiffChange",         s:blue, s:grey_238,     "")
	call <SID>X("DiffDelete",          s:red, s:grey_238,     "")
	call <SID>X("DiffText",    s:dark_yellow, s:grey_239, "none")

	" C Highlighting
	call <SID>X("cOperator",    s:aqua, "", "")
	call <SID>X("cPreCondit", s:purple, "", "")

	" PHP Highlighting
	call <SID>X("phpVarSelector",           s:red, "", "")
	call <SID>X("phpKeyword",            s:purple, "", "")
	call <SID>X("phpRepeat",             s:purple, "", "")
	call <SID>X("phpConditional",        s:purple, "", "")
	call <SID>X("phpStatement",          s:purple, "", "")
	call <SID>X("phpMemberSelector", s:foreground, "", "")

	" Ruby Highlighting
	call <SID>X("rubySymbol",                  s:green, "", "")
	call <SID>X("rubyConstant",               s:yellow, "", "")
	call <SID>X("rubyAttribute",                s:blue, "", "")
	call <SID>X("rubyInclude",                  s:blue, "", "")
	call <SID>X("rubyLocalVariableOrMethod",  s:orange, "", "")
	call <SID>X("rubyCurlyBlock",             s:orange, "", "")
	call <SID>X("rubyStringDelimiter",         s:green, "", "")
	call <SID>X("rubyInterpolationDelimiter", s:orange, "", "")
	call <SID>X("rubyConditional",            s:purple, "", "")
	call <SID>X("rubyRepeat",                 s:purple, "", "")

	" Python Highlighting
	call <SID>X("pythonInclude",     s:purple, "",     "")
	call <SID>X("pythonStatement",   s:purple, "",     "")
	call <SID>X("pythonConditional", s:purple, "",     "")
	call <SID>X("pythonRepeat",      s:purple, "",     "")
	call <SID>X("pythonException",   s:purple, "",     "")
	call <SID>X("pythonFunction",      s:blue, "",     "")
	call <SID>X("pythonFString",      s:green, "",     "")
	call <SID>X("pythonRawFString",   s:green, "",     "")
	call <SID>X("pythonDottedName ",  s:green, "", "bold")
	call <SID>X("pythonDecorator ",     s:red, "",     "")

	" Go Highlighting
	call <SID>X("goStatement",   s:purple, "", "")
	call <SID>X("goConditional", s:purple, "", "")
	call <SID>X("goRepeat",      s:purple, "", "")
	call <SID>X("goException",   s:purple, "", "")
	call <SID>X("goDeclaration",   s:blue, "", "")
	call <SID>X("goConstants",   s:yellow, "", "")
	call <SID>X("goBuiltins",    s:orange, "", "")

	" CoffeeScript Highlighting
	call <SID>X("coffeeKeyword",     s:purple, "", "")
	call <SID>X("coffeeConditional", s:purple, "", "")

	" JavaScript Highlighting
  call <SID>X("javaScript",           s:foreground, "",     "")
  call <SID>X("javaScriptBraces",     s:foreground, "",     "")
  call <SID>X("javaScriptNumber",         s:orange, "",     "")
  " pangloss/vim-javascript highlighting
  call <SID>X("jsOperator",                 s:blue, "",     "")
  call <SID>X("jsStatement",              s:purple, "",     "")
  call <SID>X("jsReturn",                 s:purple, "",     "")
  call <SID>X("jsThis",                      s:red, "",     "")
  call <SID>X("jsClassDefinition",        s:yellow, "",     "")
  call <SID>X("jsFunction",               s:purple, "",     "")
  call <SID>X("jsFuncName",                 s:blue, "",     "")
  call <SID>X("jsFuncCall",                 s:blue, "", "bold")
  call <SID>X("jsClassFuncName",            s:blue, "",     "")
  call <SID>X("jsClassMethodType",        s:purple, "",     "")
  call <SID>X("jsClassProperty",      s:foreground, "",     "")
  call <SID>X("jsRegexpString",             s:aqua, "",     "")
  call <SID>X("jsGlobalObjects",          s:orange, "",     "")
  call <SID>X("jsGlobalNodeObjects",      s:orange, "",     "")
  call <SID>X("jsExceptions",             s:yellow, "",     "")
  call <SID>X("jsBuiltins",               s:orange, "",     "")
  call <SID>X("jsObjectKey",                 s:red, "",     "")
  call <SID>X("jsObjectBraces",      s:dark_yellow, "",     "")
  call <SID>X("jsTemplateBraces",            s:red, "",     "")

  " JSON Highlighting
  call <SID>X( "jsonBraces",  s:dark_yellow, "", "" )
  call <SID>X( "jsonQuote",         s:green, "", "" )
  call <SID>X( "jsonNumber",       s:orange, "", "" )
  " call <SID>X( "jsonNoise",        s:purple, "", "" )
  call <SID>X( "jsonKeyword",         s:red, "", "" )
  " call <SID>X( "jsonKeywordMatch", s:blue, "", "" )

  " JSX
	call <SID>X("jsxAttrib",       s:orange, "", "")

	" HTML Highlighting
	call <SID>X("htmlTag",        s:red, "", "")
	call <SID>X("htmlTagName",    s:red, "", "")
	call <SID>X("htmlArg",       s:blue, "", "")
	call <SID>X("htmlScriptTag",  s:red, "", "")

  " vim-signify
  call <SID>X('SignifySignAdd',    s:green, "", "")
  call <SID>X('SignifySignChange',  s:blue, "", "")
  call <SID>X('SignifySignDelete',   s:red, "", "")

  " Startify highlighting
  call <SID>X("StartifyBracket", s:window, "", "")
  call <SID>X("StartifyFile",      s:blue, "", "")
  call <SID>X("StartifyFooter",  s:window, "", "")
  call <SID>X("StartifyHeader",   s:green, "", "")
  call <SID>X("StartifyNumber",  s:orange, "", "")
  call <SID>X("StartifyPath",    s:window, "", "")
  call <SID>X("StartifySection", s:purple, "", "")
  call <SID>X("StartifySelect",    s:aqua, "", "")
  call <SID>X("StartifySlash",   s:window, "", "")
  call <SID>X("StartifySpecial", s:window, "", "")

  " ale
  call <SID>X('ALEErrorSign',      s:red, "", "")
  call <SID>X('ALEWarningSign', s:yellow, "", "")

  " vim-peekaboo
  call <SID>X('peekabooTitle',         s:red, "", "")
  call <SID>X('peekabooTitleColon',    s:red, "", "")
  call <SID>X('peekabooReg',         s:green, "", "")
  call <SID>X('peekabooRegColon',     s:blue, "", "")
  call <SID>X('peekabooSelected',   s:yellow, "", "")

  " NERDTree highlighting
  call <SID>X('NERDTreeDirSlash',    s:red, "", "")
  call <SID>X('NERDTreeDir',       s:green, "", "")
  call <SID>X('NERDTreeExecFile', s:yellow, "", "")

	" Delete Functions
	delf <SID>X
	delf <SID>rgb
	delf <SID>colour
	delf <SID>rgb_colour
	delf <SID>rgb_level
	delf <SID>rgb_number
	delf <SID>grey_colour
	delf <SID>grey_level
	delf <SID>grey_number
endif
