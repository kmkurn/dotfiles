" Vundle {{{
set nocompatible
filetype off

" Set runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" General
Plugin 'Valloric/YouCompleteMe'                      " Autocomplete engine
Plugin 'SirVer/ultisnips'                            " Snippet engine
Plugin 'wincent/command-t'                           " Easy finding files
Plugin 'scrooloose/syntastic'                        " Syntax checker
Plugin 'itchyny/lightline.vim'                       " Minimalist statusline
Plugin 'tpope/vim-surround'                          " Surrounding made easy
Plugin 'scrooloose/nerdtree'                         " Files and directory browser
Plugin 'majutsushi/tagbar'                           " Source code browser
Plugin 'embear/vim-localvimrc'                       " Enable local Vim settings
Plugin 'editorconfig/editorconfig-vim'               " Editorconfig plugin
Plugin 'craigemery/vim-autotag'                      " Auto-update tags
Plugin 'fholgado/minibufexpl.vim'                    " Mini buffer explorer
Plugin 'tpope/vim-fugitive'                          " Git plugin
Plugin 'sjl/gundo.vim'                               " Undo trees
Plugin 'tomtom/tcomment_vim'                         " Toggle comment easily
Plugin 'easymotion/vim-easymotion'                   " Vim motions on speed!
Plugin 'tpope/vim-unimpaired'                        " Pairs of handy bracket mappings
Plugin 'mileszs/ack.vim'                             " Vim plugin for Perl's Ack

" Python/Jinja
Plugin 'davidhalter/jedi-vim'                        " Turns Vim into a Python IDE
Plugin 'tmhedberg/SimpylFold'                        " Python code folding
Plugin 'mitsuhiko/vim-jinja'                         " Jinja support

" Haskell
Plugin 'vim-scripts/syntaxhaskell.vim'               " Haskell syntax support
Plugin 'eagletmt/ghcmod-vim'                         " ghc-mod for Vim
Plugin 'Shougo/vimproc.vim'                          " ghcmod-vim dependency
Plugin 'eagletmt/neco-ghc'                           " Haskell completion

" JavaScript/NodeJS/Handlebars
Plugin 'pangloss/vim-javascript'                     " JavaScript indentation + syntax
Plugin 'moll/vim-node'                               " Node.js support
Plugin 'ternjs/tern_for_vim'                         " Turns Vim into a NodeJS IDE
Plugin 'othree/javascript-libraries-syntax.vim'      " Other JavaScript libraries support
Plugin 'mustache/vim-mustache-handlebars'            " Mustache/Handlebars template support

" HTML/XML/JSON
Plugin 'Valloric/MatchTagAlways'                     " Match HTML/XML tags
Plugin 'mitsuhiko/vim-json'                          " JSON support
Plugin 'othree/html5.vim'                            " HTML5 support

" Markdown
Plugin 'godlygeek/tabular'                           " vim-markdown dependency
Plugin 'plasticboy/vim-markdown'                     " Markdown support

" All plugins must be added before the following line
call vundle#end()               " required
filetype plugin indent on       " required
"--------------------------------------------------------}}}
" Colors {{{
" Configure terminal
set t_Co=256                    " Support 256 colors
set background=dark
"silent! colorscheme solarized
"silent! colorscheme molokai
"silent! colorscheme monokai
"silent! colorscheme badwolf
silent! colorscheme gruvbox
"--------------------------------------------------------}}}
" GUI & Fonts {{{
" Set font in MacVim
if has("gui_running")
    set guifont=Inconsolata:h14
endif

" Disable scrollbar in MacVim
set guioptions-=L
"--------------------------------------------------------}}}
" Misc {{{
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

" Always display statusline
set laststatus=2

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

" Ignore some files
set wildignore+=__pycache__     " Python cache files
set wildignore+=node_modules    " Node.js packages
set wildignore+=tags            " ctags file

" Highlight current line
set cursorline

" Visual autocomplete for command menu
set wildmenu
"--------------------------------------------------------}}}
" Tabs, Indents, Spaces {{{
" Enable indentation
set autoindent
set smartindent
set cindent

" Insert spaces when <Tab> is pressed
set expandtab

" Set default indent to be 4 spaces
set softtabstop=4
set shiftwidth=4

" Round indentation to multiple of shiftwidth
set shiftround
"--------------------------------------------------------}}}
" Key Mappings  {{{
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

" Normal Mode  {{{
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

" Location list easy shortcut
nnoremap <leader>lo :lopen<cr>
nnoremap <leader>lc :lclose<cr>

" Clear highlight and redraw screen
nnoremap <leader><space> :nohlsearch<cr>

" Toggle fold
nnoremap <space> za

" Jump to tag if there is only one matching tag, otherwise list matching tags
nnoremap <c-]> g<c-]>

" Move vertically by visual line
nnoremap j gj
nnoremap k gk
"--------------------------------------------------------}}}
" Insert Mode  {{{
" Use jk as escape key
inoremap jk <esc>

" Delete current line
inoremap <leader>D <esc>d^xi

" Convert current word into uppercase
inoremap <leader>U <esc>bveUea
"--------------------------------------------------------}}}
"--------------------------------------------------------}}}
" Command-T {{{
let g:CommandTMaxHeight = 10
"--------------------------------------------------------}}}
" UltiSnips {{{
let g:UltiSnipsExpandTrigger = g:mapleader . "<tab>"
let g:UltiSnipsJumpForwardTrigger = g:mapleader . "<tab>"
let g:UltiSnipsJumpBackwardTrigger = g:mapleader . "<s-tab>"
let g:UltiSnipsListSnippets = g:mapleader . "`"
let g:UltiSnipsEditSplit = "horizontal"
"--------------------------------------------------------}}}
" Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_filetype_map = { "html.handlebars": "handlebars" }

let g:syntastic_html_tidy_exec = "tidy5"

let g:syntastic_html_checkers = ["tidy"]
let g:syntastic_javascript_checkers = ["jshint", "jscs"]
let g:syntastic_python_checkers = ["python", "flake8", "pep257"]
let g:syntastic_less_checkers = ["lessc"]
"--------------------------------------------------------}}}
" YouCompleteMe {{{
"let g:ycm_path_to_python_interpreter = '/usr/bin/python2.6'
"--------------------------------------------------------}}}
" NERDTree {{{
nnoremap <leader>nt :NERDTreeToggle<cr>
let g:NERDTreeRespectWildIgnore = 1
"--------------------------------------------------------}}}
" Gundo {{{
nnoremap <leader>u :GundoToggle<cr>
"--------------------------------------------------------}}}
" Fugitive {{{
set statusline+=%{fugitive#statusline()}
"--------------------------------------------------------}}}
" Editorconfig {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
"--------------------------------------------------------}}}
" MiniBufExplorer {{{
nnoremap <leader>mbt :MBEToggle<cr>
nnoremap <leader>mbf :MBEFocus<cr>
"--------------------------------------------------------}}}
" MatchTagAlways {{{
nnoremap <leader>% :MtaJumpToOtherTag<cr>
"--------------------------------------------------------}}}
" Tagbar {{{
nnoremap <f9> :TagbarToggle<cr>
"--------------------------------------------------------}}}
" Localvimrc {{{
let g:localvimrc_ask = 1
"--------------------------------------------------------}}}
" vim-mustache-handlebars {{{
let g:mustache_abbreviations = 1
"--------------------------------------------------------}}}
" jedi-vim {{{
let g:jedi#completions_enabled = 0  " let YCM handle autocompletion
"--------------------------------------------------------}}}
" Vimscript file settings {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal shiftwidth=4
    autocmd FileType vim setlocal softtabstop=4
augroup END
"--------------------------------------------------------}}}
" Text file settings {{{
augroup filetype_text
    autocmd!
    autocmd FileType text setlocal wrap
    autocmd FileType text setlocal noexpandtab
augroup END
"--------------------------------------------------------}}}
" HTML file settings {{{
augroup filetype_html
    autocmd!
    autocmd FileType html setlocal shiftwidth=2
    autocmd FileType html setlocal softtabstop=2
augroup END
"--------------------------------------------------------}}}
" Python file settings {{{
augroup filetype_python
    autocmd!
    autocmd FileType python setlocal shiftwidth=4
    autocmd FileType python setlocal softtabstop=4
    autocmd FileType python setlocal foldlevel=5
augroup END
"--------------------------------------------------------}}}
" Jinja file settings {{{
augroup filetype_jinja
    autocmd!
    autocmd FileType htmljinja setlocal shiftwidth=2
    autocmd FileType htmljinja setlocal softtabstop=2
augroup END
"--------------------------------------------------------}}}
" .bowerrc file settings {{{
augroup file_bowerrc
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead .bowerrc set filetype=json
augroup END
"--------------------------------------------------------}}}
" JSON file settings {{{
augroup file_json
    autocmd!
    autocmd FIleType json setlocal shiftwidth=2
    autocmd FIleType json setlocal softtabstop=2
augroup END
"--------------------------------------------------------}}}
" JavaScript file settings {{{
augroup file_javascript
    autocmd!
    autocmd FileType javascript setlocal shiftwidth=2
    autocmd FileType javascript setlocal softtabstop=2
    autocmd FileType javascript setlocal foldmethod=indent
    autocmd FileType javascript setlocal foldlevel=5
augroup END
"--------------------------------------------------------}}}
" Markdown file settings {{{
augroup file_markdown
    autocmd!
    autocmd FileType mkd.markdown setlocal wrap
augroup END
"--------------------------------------------------------}}}
" Abbreviations  {{{
" Email
iabbrev @@ kemal.maulana@fastmail.com
"--------------------------------------------------------}}}
" Custom stuff {{{
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
