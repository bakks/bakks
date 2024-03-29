call plug#begin('~/.vim/bundle')
Plug 'junegunn/fzf',                { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'fatih/vim-go',                { 'for': 'go' }
Plug 'pangloss/vim-javascript',     { 'for': 'javascript' }
Plug 'mxw/vim-jsx',                 { 'for': ['javascript', 'javascript.jsx'] }
Plug 'prettier/vim-prettier',       { 'do': 'yarn install' }
Plug 'vim-ruby/vim-ruby',           { 'for': 'ruby' }
Plug 'derekwyatt/vim-scala',        { 'for': 'scala' }
Plug 'solarnz/thrift.vim',          { 'for': 'thrift' }
call plug#end()

" FZF
" should configure it to ignore vendor and node_modules
command! -bang -nargs=? -complete=dir GitFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <C-p> :GitFiles<CR>

let g:fzf_action = {
      \ 'ctrl-x': 'tab split' }
let $FZF_DEFAULT_OPTS = '--bind ctrl-t:down,ctrl-n:up'

let g:jsx_ext_required = 0

let g:ale_open_list = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {'go': [], 'javascript': []}

" run Prettier before saving for these file types
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.railroad Prettier

" Scala formatting
"autocmd BufWritePost *.scala !./tools/scripts/format_scala.sh %
command FormatScala !./tools/scripts/format_scala.sh %

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
"set cursorline
set timeout timeoutlen=1 ttimeoutlen=1
set autoread
set backupcopy=yes      " gets around entr running twice


nmap U :redo<CR>

" Pane navigation
nnoremap <C-m> <C-W><C-J>
nnoremap <C-w> <C-W><C-K>

" Capital T/N to iterate through search results
nmap T /<CR>
nmap N ?<CR>

nmap = :grep --exclude-dir=vendor --exclude-dir=node_modules --exclude-dir=".next" --exclude-dir="./webclient/static" -siIR "" .<Left><Left><Left>
" For these to work in the MacOS terminal you must check the following:
" Preferences -> Settings -> Keyboard tab -> 'Use option as meta key'
set <M-t>=t
set <M-n>=n
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
" reload file
nmap <C-k> :edit!<CR>
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
autocmd FileType python setlocal expandtab
autocmd FileType coffee setlocal noexpandtab
autocmd FileType go setlocal noexpandtab
autocmd FileType php setlocal noexpandtab

au BufRead,BufNewFile *.g4 set filetype=antlr4

" color related lines
syntax on
set t_Co=256
"set background=dark
colorscheme monokai

"setup highlighting for status line
hi User1 ctermfg=DarkBlue  ctermbg=LightMagenta
"hi Search ctermbg=190 ctermfg=27

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

" call to set up for man page viewing
function! Manpage()
  if line('$') == 1 | cquit | endif
  set syntax=man
  setlocal readonly
  setlocal nomodifiable
  noremap q :q!<CR>
endfunction

