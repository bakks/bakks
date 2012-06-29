set nocompatible        " no vi shit
set autoindent          " auto indent next line
set smartindent         " do this intelligently for code
set tabstop=2           " 2 char tabs
set shiftwidth=2        " 2 char >> shifts
set expandtab           " turn tabs into spaces
set incsearch           " search as we type
set hlsearch            " highlight search results


" alt-j and alt-k move the current line up and down
nnoremap <A-t> :m-2<CR>==
nnoremap <A-h> :m+<CR>==
inoremap <A-t> <Esc>:m-2<CR>==gi
inoremap <A-h> <Esc>:m+<CR>==gi
vnoremap <A-t> :m-2<CR>gv=gv
vnoremap <A-h> :m'>+1<CR>gv=gv

nmap U :redo<CR>

" dvorak mappings
nmap h <Left>
nmap t <Down>
nmap n <Up>
nmap s <Right>
vmap h <Left>
vmap t <Down>
vmap n <Up>
vmap s <Right>

" control-letter during insert mode moves
imap <C-h> <Left>
imap <C-t> <Down>
imap <C-n> <Up>
imap <C-s> <Right>

" map control-move chars to 5x
nmap <C-h> hhhhhhhh
nmap <C-t> tttttttt
nmap <C-n> nnnnnnnn
nmap <C-s> ssssssss

" jump to top
no j :0<CR>
" jump to top
no q :$<CR>
" replace text
no m s
" write file
nmap k :w<CR>

nmap <F5> :w<CR> :! make<CR>

" insert new line at 80 characters with :Doc
command -bar Doc set textwidth=80 | set fo+=to

" allow tabs in makefiles
autocmd FileType make setlocal noexpandtab

syntax on

