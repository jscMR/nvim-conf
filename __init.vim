"------------------------
" General options
"----------------------------

set lazyredraw
set ttyfast
set number relativenumber " Relative numbers for jumping
set nu rnu " Hybrid numbers, you have relative numbers and the current line number

set autoindent " autoindent always ON.
set expandtab " expand tabs
set shiftwidth=2 " spaces for autoindenting
set softtabstop=2 " remove a full pseudo-TAB when i press <BS>

set scrolloff=8 " Keep at least 8 lines below cursor

set foldmethod=manual " To avoid performance issues, I never fold anything so...

set noshowmode " We don't need to know the insert/normal mode casue we have lualine

set ignorecase
set nohlsearch " Clear search highlights

set splitbelow splitright " Set the splits to open at the right side and below


"---------------------------
" Keybindings
"----------------------------


let mapleader = ","

" Snippet for console.log

nmap <leader><leader>c oconsole.log({});<Esc>==f{a

" To avoid undo points when using arrow keys

inoremap <Left> <c-g>U<Left>
inoremap <Right> <c-g>U<Right>

" Whit leader p you can delete things without saving to register so you can

" paste what you have before

vnoremap <leader>p "_d

" Make window navigation less painful.

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Working with buffers is cool.

set hidden

map <C-d> :bnext<CR>
map <C-a> :bprev<CR>
imap <C-D> <Esc>:bnext<CR>a
imap <C-A> <Esc>:bprev<CR>a

" Move up/down in wrapped lines by display lines

noremap <silent> <Up> gk
noremap <silent> <Down> gj

" To resize window height

nnoremap <silent> <Leader>h+ :exe "resize " . (winheight(0) * 5/4)<CR>
nnoremap <silent> <Leader>h- :exe "resize " . (winheight(0) * 4/5)<CR>

" To resize window width

nnoremap <silent> <Leader>w+ :exe "vertical resize " . (winwidth(0) * 5/4)<CR>
nnoremap <silent> <Leader>w- :exe "vertical resize " . (winwidth(0) * 4/5)<CR>

" Capital Y to copy to the end of the line like C or D

nnoremap Y y$

" To move in the search list but keeping the cursor in the middle of screen

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv

" To close buffer without closing splits

nnoremap <silent> <C-q> :lclose<bar>b#<bar>bd #<CR>
