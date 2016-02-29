startinsert

syntax on

set mouse=a

set clipboard=unnamed

set timeoutlen=1000 ttimeoutlen=0

set ruler

set whichwrap+=<,>,[,]

set showmatch

" search settings
set hlsearch
set incsearch
set smartcase

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

" show trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" nano-like keymappings
inoremap <C-k> <C-o>d$<C-o>:s/^$\n//e<Enter><C-o>:noh<Enter>

" <Ctrl-Shift-c> copy shortcut
inoremap <C-C> <C-o>yy
" <Ctrl-Shift-v> paste shortcut
inoremap <C-V> <C-o>p

inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0

inoremap <C-j> <C-o>J
" <Cmd-z> undo shortcut
inoremap Ω <C-o>u
" <Cmd-Shift-z> redo shortcut
inoremap ¸ <C-o><C-R>

inoremap <TAB> <C-t>
inoremap <S-TAB> <C-d>

inoremap <C-f> <C-o>/
inoremap <C-r> <C-o>:%s

" <Cmd-s> save shortcut
inoremap ß <C-o>:w<Enter>
inoremap <C-s> <C-o>ZZ
inoremap <C-x> <C-o>ZQ

" <Alt-f> formatting shortcut
inoremap ƒ <C-o>:set textwidth=80<Enter><C-o>gg<C-o>gqG<C-o>:set textwidth=0<Enter>
" <Alt-F> formatting shortcut
inoremap Ï <C-o>:%! jalopy.sh -q --lang java<Enter>

" <Alt-b> block selection shortcut
inoremap ∫ <C-o><C-V>
inoremap <S-Up> <C-o>v<Up>
inoremap <S-Down> <C-o>v<Down>
inoremap <S-Left> <C-o>v<Left>
inoremap <S-Right> <C-o>v<Right>
inoremap <C-S-Left> <C-o>v<C-Left>
inoremap <C-S-Right> <C-o>v<C-Right>

vnoremap <Up> <C-c>i<Up>
vnoremap <Down> <C-c>i<Down>
vnoremap <Left> <C-c>i<Left>
vnoremap <Right> <C-c>i<Right>

vnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
vnoremap <S-Left> <Left>
vnoremap <S-Right> <Right>

vnoremap <C-k> d

" <Alt-C> copy shortcut
vnoremap <C-C> y
" <Alt-V> paste shortcut
vnoremap <C-V> p

vnoremap <C-e> $
vnoremap <C-a> 0

vnoremap <C-j> J
" <Cmd-z> undo shortcut
vnoremap Ω u
" <Cmd-Z> redo shortcut
vnoremap ¸ <C-R>

vnoremap <TAB> >
vnoremap <S-TAB> <

vnoremap <C-f> /
vnoremap <C-r> :s

" <Cmd-s> save shortcut
vnoremap ß <C-c>:w<Enter>
vnoremap <C-s> <C-c>:wq<Enter>
vnoremap <C-x> <C-c>:q!<Enter>

" <Alt-f> formatting shortcut
vnoremap ƒ :set textwidth=80<Enter>gvgq:set textwidth=0<Enter>i
" <Alt-F> formatting shortcut
vnoremap Ï :! jalopy.sh -q --lang java<Enter>i

