" PATHOGEN INITIALIZATION  {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off
call pathogen#infect()
Helptags

"--------------------------------------------------------}}}

" BASIC SETTINGS  {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Configure terminal
set t_Co=256                    " Support 256 colors
set background=dark
silent! colorscheme molokai

" Display relative line number
set relativenumber

" Set maximum length
set textwidth=79

" Disable line wrapping
set nowrap

" Allow hidden buffer
set hidden

" Autoread files
set autoread

" Enable syntax highlighting, autodetect filetype, and filetype-based indent
syntax on
filetype on
filetype plugin indent on

" Enable indentation
set autoindent
set smartindent
set cindent

" Set indentation to 4 spaces
set shiftwidth=4
set softtabstop=4       " Insert spaces for <Tab>
set expandtab           " Use spaces for <Tab>

" Round indentation to multiple of shiftwidth
set shiftround

" Always display statusline
set laststatus=2

" Format statusline
set statusline=%F\ \ \           " Full path to file
set statusline+=%y               " Type of file
set statusline+=%m               " Modified flag
set statusline+=%=               " Align right from this point
set statusline+=%l,%c\ \ \       " Current position
set statusline+=%L\ lines\ \ \   " Total number of lines
set statusline+=--%p%%--         " Percentage through file in lines

" Show partial commmand in the last line of the screen
set showcmd

" Highlight and incremental search
set hlsearch
set incsearch

" Ignore case if search pattern is all lowercase, case sensitive otherwise
set ignorecase
set smartcase

" Briefly jump to matching bracket
set showmatch

" No backup files
set nobackup
set noswapfile

"--------------------------------------------------------}}}

" KEY MAPPINGS  {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = ","
let maplocalleader = "\\"           " Single backslash

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Disable default escape keys
inoremap <c-[> <nop>
inoremap <esc> <nop>

" Some other disabled things
nnoremap : <nop>

" Normal Mode  {{{2
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set capital Y to yank until end of line
nnoremap Y y$

" Move to the beginning of current line
nnoremap H 0

" Move to the end of current line
nnoremap L $

" Always use very magic regex parsing mode when searching
nnoremap / /\v
nnoremap ? ?\v

" Navigate multiple windows easily
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Some useful file operation shortcuts
nnoremap <space> :
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>

" Easy working with .vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>:nohlsearch<cr>

" Convert current word into uppercase
nnoremap <leader>U bveU

" Quickfix window easy shortcut
nnoremap <leader>co :copen<cr>
nnoremap <leader>cc :cclose<cr>
nnoremap <leader>cj :cnext<cr>
nnoremap <leader>ck :cprevious<cr>

" Location list easy shortcut
nnoremap <leader>lo :lopen<cr>
nnoremap <leader>lc :lclose<cr>
nnoremap <leader>lj :lnext<cr>
nnoremap <leader>lk :lprevious<cr>

" Clear highlight and redraw screen
nnoremap <f5> :nohlsearch<cr>:redraw!<cr>

"--------------------------------------------------------}}}

" Insert Mode  {{{2
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use jk as escape key
inoremap jk <esc>

" Delete current line
inoremap <leader>D <esc>d^xi

" Convert current word into uppercase
inoremap <leader>U <esc>bveUea

"--------------------------------------------------------}}}

"--------------------------------------------------------}}}

" AUTOCOMMANDS  {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Commenting current line in source codes
augroup comment
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType cpp nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType c nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType java nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType vim nnoremap <buffer> <localleader>c I"<esc>
augroup END

" Vimscript file settings
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" Text file settings
augroup filetype_text
    autocmd!
    autocmd FileType text setlocal wrap
    autocmd FileType text setlocal noexpandtab
augroup END


"--------------------------------------------------------}}}

" ABBREVIATIONS  {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Email
iabbrev @@ kemskems12@gmail.com

"--------------------------------------------------------}}}

" PLUGIN-RELATED SETTINGS {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" UltiSnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsListSnippets = g:mapleader . "<tab>"
let g:UltiSnipsEditSplit = "horizontal"

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'passive_filetypes': ['python'] }

" MiniBufExpl
nnoremap <leader>j :MBEFocus<cr>

" NERDTree
nnoremap <leader>n :NERDTreeToggle<cr>

" Ack
nnoremap <leader>a :Ack<space>

"--------------------------------------------------------}}}

