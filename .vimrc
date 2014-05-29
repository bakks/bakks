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
" delete newline
no e :s/\n//<CR>

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

" function for getting file permissions used in status line
function! s:Get_file_perm()
  let a=getfperm(expand('%:p'))
  return a
  if strlen(a)
    return a
  else
    let b=printf("%o", xor(0777,system("umask")))
    let c=""
    for d in [0, 1, 2]
      let c.=and(b[d], 4) ? "r" : "-"
      let c.=and(b[d], 2) ? "w" : "-"
      let c.=and(b[d], 1) ? "x" : "-"
    endfor
    return c
  endif
endfunction

let w:file_perm=<sid>Get_file_perm()

" set statusline
set statusline=
set statusline+=%1*\%<%F\                 " File+path
set statusline+=%2*\%{w:file_perm}        " file permissions
set statusline+=%9*\ %=\                  " filler
set statusline+=%4*\%m%r%w                " Modified? Readonly?
set statusline+=%1*\ %l/%L:%02c           " row/total:column

