

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ ['darkestgreen', 'brightgreen', 'bold'], ['white', 'gray5']]
let s:p.normal.right = [ ['white', 'gray5']]
let s:p.inactive.left = [ ['darkestgreen', 'brightgreen', 'bold'], ['white', 'gray5']]
let s:p.inactive.right = [ ['white', 'gray5']]
let s:p.insert.left = [ ['darkestcyan', 'white', 'bold'], ['white', 'darkestblue'] ]
let s:p.insert.right = [ ['white', 'darkestblue']]
let s:p.replace.left = [ ['white', 'brightred', 'bold'], ['white', 'gray4'] ]
let s:p.visual.left = [ ['darkred', 'brightorange', 'bold'], ['white', 'gray4'] ]
let s:p.normal.middle = [ [ 'gray7', 'gray5' ] ]
let s:p.insert.middle = [ [ 'mediumcyan', 'darkestblue' ] ]
let s:p.inactive.middle = [ [ 'gray7', 'gray5' ] ]
let s:p.replace.middle = s:p.normal.middle
let s:p.replace.right = s:p.normal.right
let s:p.tabline.left = [ [ 'white', 'gray19' ] ]
let s:p.tabline.tabsel = [ [ 'white', 'darkestblue' ] ]
let s:p.tabline.middle = [ [ 'white', 'gray19' ] ]
let s:p.tabline.right = [ [ 'gray9', 'gray3' ] ]
let s:p.normal.error = [ [ 'gray9', 'brightestred' ] ]
let s:p.normal.warning = [ [ 'gray1', 'yellow' ] ]

let g:lightline#colorscheme#toztan3#palette = lightline#colorscheme#fill(s:p)
