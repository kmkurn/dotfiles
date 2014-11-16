" VUNDLE INITIALIZATION  {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
filetype off

" Set runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" List of plugins here
Plugin 'Valloric/YouCompleteMe'         " Autocomplete engine
Plugin 'SirVer/ultisnips'               " Snippet engine
Plugin 'honza/vim-snippets'             " Snippet collections
Plugin 'wincent/command-t'              " Easy finding files
Plugin 'scrooloose/syntastic'           " Syntax checker
Plugin 'itchyny/lightline.vim'          " Minimalist statusline

" All plugins must be added before the following line
call vundle#end()               " required
filetype plugin indent on       " required

"--------------------------------------------------------}}}

" BASIC SETTINGS  {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Configure terminal
set t_Co=256                    " Support 256 colors
set background=dark
silent! colorscheme molokai

" Set font in gvim
if has("gui_running")
    set guifont=Inconsolata\ 10
endif

" Display relative line number
set relativenumber

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
nnoremap ; :
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :q!<cr>

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

" Toggle fold
nnoremap <space> za

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
    autocmd FileType cpp nnoremap <buffer> <localleader>c I// <esc>
    autocmd FileType c nnoremap <buffer> <localleader>c I// <esc>
    autocmd FileType java nnoremap <buffer> <localleader>c I// <esc>
    autocmd FileType vim nnoremap <buffer> <localleader>c I" <esc>
augroup END

" Detect .md files as markdown
augroup markdown
    autocmd!
    autocmd BufRead,BufNewFile,BufNew *.md set filetype=markdown
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

" Markdown file settings
augroup filetype_md
    autocmd!
    autocmd FileType markdown setlocal wrap
augroup END

" HTML file settings
augroup filetype_html
    autocmd!
    autocmd FileType html setlocal shiftwidth=2
    autocmd FileType html setlocal softtabstop=2
augroup END

" Python file settings
augroup filetype_python
    autocmd!
    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType python setlocal foldlevel=99
    " Single line comment
    autocmd FileType python nnoremap <buffer> <localleader>c I# <esc>
    " Multiline comment
    autocmd FileType python vnoremap <buffer> <localleader>c <esc>'<O"""<esc>'>o"""<esc>
augroup END


"--------------------------------------------------------}}}

" ABBREVIATIONS  {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Email
iabbrev @@ kemskems12@gmail.com

"--------------------------------------------------------}}}

" PLUGIN-RELATED SETTINGS {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Command-T
let g:CommandTMaxHeight = 10

" UltiSnips
let g:UltiSnipsExpandTrigger = g:mapleader . "<tab>"
let g:UltiSnipsJumpForwardTrigger = g:mapleader . "<tab>"
let g:UltiSnipsListSnippets = g:mapleader . "`"
let g:UltiSnipsEditSplit = "horizontal"

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_check_on_open = 1

"--------------------------------------------------------}}}

" PLUGIN-LIKE STUFF  {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enclose current WORD in quotes, parentheses, etc
nnoremap <leader>" mzBi"<esc>lEa"<esc>`zl
nnoremap <leader>' mzBi'<esc>lEa'<esc>`zl
nnoremap <leader>< mzBi<<esc>lEa><esc>`zl
nnoremap <leader>( mzBi(<esc>lEa)<esc>`zl
nnoremap <leader>[ mzBi[<esc>lEa]<esc>`zl
nnoremap <leader>_ mzBi_<esc>lEa_<esc>`zl

inoremap <leader>" <esc>Bi"<esc>lEa"
inoremap <leader>' <esc>Bi'<esc>lEa'
inoremap <leader>< <esc>Bi<<esc>lEa>
inoremap <leader>( <esc>Bi(<esc>lEa)
inoremap <leader>[ <esc>Bi[<esc>lEa]
inoremap <leader>_ <esc>Bi_<esc>lEa_

"--------------------------------------------------------}}}

