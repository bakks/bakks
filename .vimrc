execute pathogen#infect()

set nocompatible        " no vi shit
set autoindent          " auto indent next line
set smartindent         " do this intelligently for code
set tabstop=2           " 2 char tabs
set shiftwidth=2        " 2 char >> shifts
set expandtab           " turn tabs into spaces
set incsearch           " search as we type
set hlsearch            " highlight search results
set laststatus=2        " always show status line
set backspace=indent,eol,start
filetype plugin on
set modeline
set modelines=10
set cursorline


nmap U :redo<CR>

" Pane navigation
nnoremap <C-m> <C-W><C-J>
nnoremap <C-w> <C-W><C-K>

" Capital T/N to iterate through search results
nmap T /<CR>
nmap N ?<CR>

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
imap <C-e> <C-x><C-o>

" map control-move chars to 5x
nmap <C-h> hhhhhhhh
nmap <C-t> tttttttt
nmap <C-n> nnnnnnnn
nmap <C-s> ssssssss

" jump to top
no j :0<CR>
" jump to bottom
no q :$<CR>
" replace text
no m s
" write file
nmap k :w<CR>
" delete newline
no e :s/\n//<CR>:noh<CR>

" save and run make in current dir
nmap <F5> :w<CR> :! make<CR>
" kill trailing whitespace
nmap - :%s/\s\+$//<CR>

" insert new line at 80 characters with :Doc
command -bar Doc set textwidth=80 | set fo+=to

" allow tabs in makefiles and python
autocmd FileType make setlocal noexpandtab
autocmd FileType python setlocal noexpandtab
autocmd FileType coffee setlocal noexpandtab
autocmd FileType go setlocal noexpandtab

" color related lines
syntax on
set t_Co=256
colorscheme paintbox

"setup highlighting for status line
hi User1 ctermfg=190  ctermbg=27
hi User2 ctermfg=190  ctermbg=62
hi User3 ctermfg=190  ctermbg=132
hi User4 ctermfg=190  ctermbg=52
hi User5 ctermfg=190  ctermbg=54
hi User9 ctermfg=89  ctermbg=89

hi Search  ctermbg=190 ctermfg=27

" set statusline
set statusline=
set statusline+=%1*\%<%F\                 " File+path
set statusline+=%9*\ %=\                  " filler
set statusline+=%4*\%m%r%w                " Modified? Readonly?
set statusline+=%1*\ %l/%L:%02c           " row/total:column

" re-open files at old line
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

