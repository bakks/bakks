
set nocompatible        " no vi shit
set autoindent          " auto indent next line
set smartindent         " do this intelligently for code
set tabstop=4           " 4 char tabs
set shiftwidth=4        " 4 char >> shifts
set incsearch           " search as we type
set hlsearch			" highlight search results


" alt-j and alt-k move the current line up and down
nnoremap <A-t> :m-2<CR>==
nnoremap <A-h> :m+<CR>==
inoremap <A-t> <Esc>:m-2<CR>==gi
inoremap <A-h> <Esc>:m+<CR>==gi
vnoremap <A-t> :m-2<CR>gv=gv
vnoremap <A-h> :m'>+1<CR>gv=gv

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

no j :0<CR>
no m s
nmap k :w<CR>

nmap <F5> :w<CR> :! make<CR>

" remove trailing whitespace with :Clean
command Clean %s/[\t ][\t ]*$//g

" insert new line at 80 characters with :Doc
command -bar Doc set textwidth=80 | set fo+=to

syntax on

set nocp
filetype plugin on

"helptags $HOME/.vim/doc
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

set completeopt-=preview "disable annoying window
let OmniCpp_ShowPrototypeInAbbr = 1 "show function parameters
let OmniCpp_MayCompleteScope = 1 "autocomplete after ::
let OmniCpp_NamespaceSearch=2
let OmniCpp_DefaultNamespaces = ["std"]

