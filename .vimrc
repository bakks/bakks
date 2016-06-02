execute pathogen#infect()

" Ctrl-P plugin config
set runtimepath^=~/.vim/bundle/ctrlp.vim
" Run :helptags ~/.vim/bundle/ctrlp.vim/doc to install

let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")':   ['<c-t>', '<down>'],
  \ 'PrtSelectMove("k")':   ['<c-n>', '<up>'],
  \ 'PrtHistory(-1)':       [],
  \ 'AcceptSelection("t")': [],
  \ }

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

nmap = :grep -siI "" **/*<Left><Left><Left><Left><Left><Left>
"set <M-t>=t
"set <M-n>=n
" oaeuaoeu
nmap <M-t> :cn<CR>
nmap <M-n> :cp<CR>

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
"set background=dark
colorscheme paintbox

"setup highlighting for status line
hi User1 ctermfg=6  ctermbg=21
hi Search ctermbg=190 ctermfg=27

" set statusline
set statusline=
set statusline+=%1*\%<%F\              " File+path
set statusline+=\ %=\               " filler
set statusline+=%1*\%m%r%w             " Modified? Readonly?
set statusline+=\ %l/%L:%02c           " row/total:column

" set working directory to git project root
" or directory of current file if not git project
" http://inlehmansterms.net/2014/09/04/sane-vim-working-directories/
function! SetProjectRoot()
  " default to the current file's directory
  lcd %:p:h
  let git_dir = system("git rev-parse --show-toplevel")
  " See if the command output starts with 'fatal' (if it does, not in a git repo)
  let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
  " if git project, change local directory to git project root
  if empty(is_not_git_dir)
    lcd `=git_dir`
  endif
endfunction

" follow symlinked file
function! FollowSymlink()
  let current_file = expand('%:p')
  " check if file type is a symlink
  if getftype(current_file) == 'link'
    " if it is a symlink resolve to the actual file path
    "   and open the actual file
    let actual_file = resolve(current_file)
    silent! execute 'file ' . actual_file
  end
endfunction


" re-open files at old line
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif

  autocmd BufRead *
    \ call FollowSymlink() |
    \ call SetProjectRoot()
endif

