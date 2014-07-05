" Cute ASCII-art cat
echo ">^.^<"



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC SETTINGS  {{{1
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Display line number
set number

" Enable line wrapping
set wrap

" Round indentation to multiple of shiftwidth
set shiftround

" Format statusline
set statusline=%f            " Path to file
set statusline+=\ -\         " Separator
set statusline+=FileType:\   " Label
set statusline+=%y           " Type of file
set statusline+=%m           " Modified flag
set statusline+=%=           " Align right from this point
set statusline+=Loc:\        " Label
set statusline+=%l           " Current line number
set statusline+=,            " Separator
set statusline+=%c\ \        " Current column number
set statusline+=Total:\      " Label
set statusline+=%L           " Total number of lines
set statusline+=%8p%%        " Percentage through file in lines

" Always display statusline
set laststatus=2

" Start editing with all folds closed
set foldlevelstart=0

" Highlight and incremental search
set hlsearch
set incsearch



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY MAPPINGS  {{{1
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = ","
let maplocalleader = "\\"

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Normal Mode  {{{2
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Edit ~/.vimrc in a split window
nnoremap <leader>ev :split $MYVIMRC<cr>

" Load ~/.vimrc in current session
nnoremap <leader>sv :source $MYVIMRC<cr>

" Move a line downwards
nnoremap <leader>- ddp

" Move a line upwards
nnoremap <leader>_ kddpk

" Convert current word into uppercase
nnoremap <leader>U bveU

" Enclose current word in double quotes
nnoremap <leader>" bi"<esc>lea"<esc>l

" Enclose current word in single quotes
nnoremap <leader>' bi'<esc>lea'<esc>l

" Move to the beginning of current line
nnoremap H 0

" Move to the end of current line
nnoremap L $

" Open previous buffer in split window
nnoremap <leader>eb :execute "rightbelow split " . bufname("#")<cr>

" Highlight trailing whitespace as error
nnoremap <leader>w :match ErrorMsg /\v +$/<cr>

" Clear trailing whitespace highlight
nnoremap <leader>W :match<cr>

" Always use very magic regex parsing mode when searching
nnoremap / /\v

" Clear highlight from last search
nnoremap <leader>cl :nohlsearch<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert Mode  {{{2
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use jk as escape key
inoremap jk <esc>

" Delete current line
inoremap <leader>D <esc>ddi

" Convert current word into uppercase
inoremap <leader>U <esc>bveUea

" Enclose current word in double quotes
inoremap <leader>" <esc>bi"<esc>lea"

" Enclose current word in single quotes
inoremap <leader>' <esc>bi'<esc>lea'



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCOMMANDS  {{{1
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Commenting current line in source codes
augroup comment
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType cpp nnoremap <buffer> <localleader>c I//<esc>
augroup END

" Vimscript file settings
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ABBREVIATIONS  {{{1
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Email
iabbrev @@ kemskems12@gmail.com

