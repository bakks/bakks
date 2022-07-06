" ========================
" Import Plugins
" ========================

" auto install vim-plug and plugins
let plug_install = 0
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    execute '!curl -fL --create-dirs -o ' . autoload_plug_path .
        \ ' https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . fnameescape(autoload_plug_path)
    let plug_install = 1
endif
unlet autoload_plug_path
call plug#begin(stdpath('config') . '/plugged')

" plugins here ...
Plug 'junegunn/fzf',                { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'w0rp/ale'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'fatih/vim-go',                { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'pangloss/vim-javascript',     { 'for': 'javascript' }
Plug 'mxw/vim-jsx',                 { 'for': ['javascript', 'javascript.jsx'] }
Plug 'prettier/vim-prettier',       { 'do': 'yarn install' }
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mhinz/vim-startify'
call plug#end()
call plug#helptags()

" auto install vim-plug and plugins:
if plug_install
    PlugInstall --sync
endif
unlet plug_install

" ========================
" Plugin Configuration
" ========================

" Control-P opens FZF finder that ignores .gitignore files
nnoremap <C-p> :GitFiles<CR>

let g:fzf_action = {
      \ 'ctrl-x': 'tab split' }
let $FZF_DEFAULT_OPTS = '--bind ctrl-t:down,ctrl-n:up'

let g:jsx_ext_required = 0

let g:ale_open_list = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {'go': [], 'javascript': []}

lua << END
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "go", "gomod", "vim", "json", "javascript", "html", "make", "lua" },
  highlight = {
    enable = true,
  },
}

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}
END

" run Prettier before saving for these file types
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.railroad Prettier

"au FileType go nnoremap <silent> cd <Plug>(go-def-tab)
"au FileType go nmap gd <Plug>(go-def)

" turn off some go-vim functionality
let g:go_def_mapping_enabled = 0
let g:go_textobj_enabled = 0
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'


" ========================
" Basic Neovim Configuration
" ========================

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
set timeout timeoutlen=1000 ttimeoutlen=1000
set autoread
set backupcopy=yes      " gets around entr running twice

" insert new line at 80 characters with :Doc
command -bar Doc set textwidth=80 | set fo+=to

" allow tabs in makefiles and python
autocmd FileType make setlocal noexpandtab
autocmd FileType python setlocal expandtab
autocmd FileType coffee setlocal noexpandtab
autocmd FileType php setlocal noexpandtab

au BufRead,BufNewFile *.g4 set filetype=antlr4

" set statusline
set statusline=
set statusline+=%1*\%<%F\              " File+path
set statusline+=\ %=\                  " filler
set statusline+=%1*\%m%r%w             " Modified? Readonly?
set statusline+=\ %l/%L:%02c           " row/total:column


" ========================
" Basic Key Bindings
" ========================
"
let g:mapleader="c"

" U to redo
nmap U :redo<CR>

" Pane navigation
nnoremap <C-m> <C-W><C-J>
nnoremap <C-w> <C-W><C-K>

" Capital T/N to iterate through search results
nmap T /<CR>
nmap N ?<CR>

nmap = :grep --exclude-dir=vendor --exclude-dir=node_modules --exclude-dir=".next" --exclude-dir="./webclient/static" -siIR "" .<Left><Left><Left>
nmap <M-t> :cn<CR>
nmap <M-n> :cp<CR>

" dvorak movement mappings
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
imap » <Right>
imap <C-e> <C-x><C-o>

" map control-move chars to 5x
nmap <C-h> hhhhhhhhhhhh
nmap <C-t> tttttttt
nmap <C-n> nnnnnnnn
nmap <C-s> ssssssssssss
nmap » ssssssssssss
imap <C-h> hhhhhhhhhhhh
imap <C-t> tttttttt
imap <C-n> nnnnnnnn
imap » ssssssssssss
vmap <C-h> hhhhhhhhhhhh
vmap <C-t> tttttttt
vmap <C-n> nnnnnnnn
vmap » ssssssssssss

" tab controls
nmap B gt
nmap M gT

" jump to top
no j :0<CR>
" jump to bottom
no q :$<CR>
" replace text
no m s
" write file
nmap k :w<CR>
" reload file
nmap <C-r> :edit!<CR>
" delete newline
no e :s/\n//<CR>:noh<CR>
" jump to end of line
nmap <C-e> $
" jump to beginning of line
nmap <C-a> 0
" reload vim config
nmap ; :source ~/.config/nvim/init.vim<CR>

" save and run make in current dir
nmap <F5> :w<CR> :! make<CR>
" kill trailing whitespace
nmap - :%s/\s\+$//<CR>

" ========================
" Plugin Key Bindings
" ========================

nmap <silent> P :NvimTreeToggle<CR>
vmap <silent> P :NvimTreeToggle<CR>
nmap <silent> <leader>d <Plug>(go-def-tab)

" ========================
" Color Scheme
" ========================

syntax on
set t_Co=256
colorscheme monokai
hi Normal ctermbg=233  " darken background a bit

"setup highlighting for status line
hi User1 ctermfg=DarkBlue  ctermbg=LightMagenta

" ========================
" Re-Open files at old line
" ========================

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

