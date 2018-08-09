" Willis .vimrc 18.01

syntax on			" Enable syntax highlighting
set nocompatible	" Use gVim defaults (better)
set backspace=2		" Allow backspacing over everything
set cindent			" Clever autoindent
set encoding=utf-8  " Unicode encoding
set foldenable		" Allows folding code
set foldmethod=marker " Marks foldstarts/ends with {{{ }}}
set mouse=a			" Enable mouse
set mousehide		" Hide mouse cursor while typing
set nobackup		" Don't write backup files
set nocopyindent
set noerrorbells	" Don't beep
set noswapfile		" Don't write a swap file
set report=0
set showbreak=>
set showmatch		" Highlight matching brackets
set smartcase		" Upper-case sensitive search otherwise insensitive
set gdefault		" Automatically search globally
set incsearch		" Increment search
set hlsearch		" Highlight searched words
set paste			" Put Vim in paste mode (middle mouse click))
set ruler			" Display line numbers on the bottom right
set shiftwidth=4	" Allows the use of < and > for VISUAL indenting
set softtabstop=4   " Counts n spaces when DELETE or BCKSPCE is used
set smarttab
set tabstop=4		" Tabwith is 4spaces
"set expandtab		" Insert spaces instead of tabs
set termencoding=utf-8
set ttyfast			" Improves redrawing
set undolevels=200	" Max 200 undolevels
set viminfo='20,\"500 " Keep a .viminfo file.
set wildchar=<tab>
set wildmenu
set wildmode=longest:full,full

"highlight redundant whitespaces and tabs.
"highlight RedundantSpaces ctermbg=red guibg=red
"match RedundantSpaces /\s\+$\| \+\ze\t\|\t/

"  Enable filetype plugins and indention
filetype on
filetype plugin on
filetype indent on

" Filetype specific settings
au FileType sh,php,perl,python,ruby map <F5> :!./%<CR>
au FileType tex,latex map <F5> :w<CR>:!pdflatex "%"<CR>
au FileType java map <F5> :w<CR>:!javac "%" && java %:r<CR>
au FileType java map <F6> :!java %:r
au FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
au FileType python map <F5> :w<CR>:!python "%"<CR>
let python_highlight_all=1

" Bindings
nmap X :x<CR>
inoremap <C-x> <esc>:x<CR>
inoremap <C-v> <esc>p i
map + :next<CR>
map - :prev<CR>
map # :w<CR>:next<CR>
nmap S :w !sudo tee %<CR>

map <C-t>     :tabnew<CR>
map <C-w>     :tabclose<CR>
map <C-v>	  !!xsel<CR>

