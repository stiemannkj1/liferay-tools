startinsert

syntax on

set mouse=a

set clipboard=unnamed

set timeoutlen=1000 ttimeoutlen=0

set whichwrap+=<,>,[,]

" softwrap settings
set wrap
set linebreak
set nolist
set textwidth=0
set wrapmargin=0

" tab settings
set tabstop=4
set softtabstop=0
set noexpandtab
set shiftwidth=4

" nano-like keymappings
inoremap <C-k> <C-o>dd

" <Alt-c> copy shortcut
inoremap ç <C-o>yy
" <Alt-v> paste shortcut
inoremap √ <C-o>P

inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0
inoremap <C-w> <C-o>w
inoremap <C-b> <C-o>b
inoremap <C-v> <C-o><C-F><C-o>L
inoremap <C-y> <C-o><C-B><C-o>H

inoremap <C-j> <C-o>J
" <Alt-z> undo shortcut
inoremap Ω <C-o>u
" <Alt-Z> redo shortcut
inoremap ¸ <C-o><C-R>

inoremap <TAB> <C-t>
inoremap <S-TAB> <C-d>

inoremap <C-f> <C-o>/
inoremap <C-r> <C-o>:%s///

inoremap <C-x> <C-o>ZZ
inoremap <C-c> <C-o>ZQ

" <Alt-s> block selection shortcut
inoremap ß <C-o><C-V>
inoremap <S-Up> <C-o>v<Up>
inoremap <S-Down> <C-o>v<Down>
inoremap <S-Left> <C-o>v<Left>
inoremap <S-Right> <C-o>v<Right>

vnoremap <Up> <C-c>i<Up>
vnoremap <Down> <C-c>i<Down>
vnoremap <Left> <C-c>i<Left>
vnoremap <Right> <C-c>i<Right>

vnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
vnoremap <S-Left> <Left>
vnoremap <S-Right> <Right>

vnoremap <C-k> d
" <Alt-c> copy shortcut
vnoremap ç y
" <Alt-v> paste shortcut
vnoremap √ P

vnoremap <C-e> $
vnoremap <C-a> 0
vnoremap <C-w> w
vnoremap <C-b> b
vnoremap <C-v> <C-F>L
vnoremap <C-y> <C-B>H

vnoremap <C-j> J
" <Alt-z> undo shortcut
vnoremap Ω u
" <Alt-Z> redo shortcut
vnoremap ¸ <C-R>

vnoremap <TAB> >
vnoremap <S-TAB> <

vnoremap <C-f> /
vnoremap <C-r> :s///

vnoremap <C-x> <C-c>:wq<Enter>
vnoremap <C-c> <C-c>:q!<Enter>

