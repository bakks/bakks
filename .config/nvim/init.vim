" ========================
" Import Plugins
" ========================

" Debugging plugins: run the following commands
" PlugInstall
" PlugUpdate
" TSUpdate

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
Plug 'ms-jpq/coq_nvim',             { 'branch': 'coq' }
Plug 'ms-jpq/coq.artifacts',        { 'branch': 'artifacts' }
Plug 'github/copilot.vim',          { 'do': ':Copilot setup' }
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
  ensure_installed = { "go", "gomod", "vim", "json", "javascript", "html", "make", "lua", "python" },
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
 },
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true,
}

-- nvim-lspconfig settings:
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', 'ce', vim.diagnostic.open_float, opts)

local getdef = function()
  vim.lsp.buf.definition({ reuse_win=true })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'cD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'cd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'ck', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'ci', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'cs', vim.lsp.buf.signature_help, bufopts)
  -- vim.keymap.set('n', 'ctd', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'cR', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'cca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'cr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'cf', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set('n', 'ct', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', 'cn', vim.diagnostic.goto_prev, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local lspconfig = require('lspconfig')

-- COQ (autocompletion) settings
vim.g.coq_settings = {
  auto_start = 'shut-up',

  completion = {
    always = false,
  },

  keymap = {
    jump_to_mark = '',
    recommended = false,
    manual_complete = 'ce',
  },

  clients = {
    tabnine = {
      enabled = false,
    }
  },

  display = {
    ghost_text = {
      enabled = true,
    },
    pum = {
      fast_close = false,
      y_max_len = 7,
      kind_context = { "", "" },
    },
    preview = {
      border = "solid",
      positions = { east = 3, south = 2, north = 1, west = nil },
    },
  }
}

-- Enable some language servers with the additional completion capabilities offered by coq_nvim
local servers = { 'gopls', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({
    on_attach = on_attach,
    flags = lsp_flags,
  }))
end

local function bufwinid(bufnr)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == bufnr then
      return win
    end
  end
end

-- This is hacked scripting to get LSP go-to-definition
-- to use tabs that are already open, and otherwise open a 
-- new one. Can probably be simplified.
vim.lsp.handlers["textDocument/definition"] = function(err, result, ctx, config)
  local client_encoding = vim.lsp.get_client_by_id(ctx.client_id).offset_encoding
  if err then
    vim.notify(err.message)
    return
  end
  if result == nil then
    vim.notify("Location not found")
    return
  end

  local uri = result.uri or result.targetUri or result[1].uri or result[1].targetUri
  if uri == nil then
    return false
  end
  local bufnr = vim.uri_to_bufnr(uri)
  local win = bufwinid(bufnr)
    or vim.api.nvim_command('tabnew')

  if vim.tbl_islist(result) and result[1] then
    vim.lsp.util.jump_to_location(result[1], client_encoding, true)

    if #result > 1 then
      vim.fn.setqflist(vim.lsp.util.locations_to_items(result, client_encoding))
      vim.api.nvim_command("copen")
    end
  else
    vim.lsp.util.jump_to_location(result, client_encoding, true)
  end
end

-- Configure diagnostics
-- Turn off left bar signs
vim.diagnostic.config({ signs = false })
-- Show full description in window on hover
--vim.o.updatetime = 250
--vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

END


" run Prettier before saving for these file types
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.railroad Prettier

" turn off some go-vim functionality
let g:go_def_mapping_enabled = 0
let g:go_textobj_enabled = 0
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_fmt_command = 'gopls'
let g:go_fmt_fail_silently = 0
let g:go_autodetect_gopath = 1
let g:go_term_enabled = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_autosave = 1

" Github copilot

let g:copilot_node_command = "/usr/local/Cellar/node@16/16.18.1/bin/node"

nmap ll :Copilot panel<CR>

" ==========================
" Basic Neovim Configuration
" ==========================

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
set timeout timeoutlen=400 ttimeoutlen=400
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
imap » <Right>
imap <C-e> <C-x><C-o>

" map control-move chars to 5x
nmap <C-h> hhhhhhhhhhhh
nmap <C-t> tttttttt
nmap <C-n> nnnnnnnn
nmap » ssssssssssss
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

nmap Q :q<CR>

" ========================
" Plugin Key Bindings
" ========================

nmap <silent> P :NvimTreeToggle<CR>
vmap <silent> P :NvimTreeToggle<CR>
" Turning these off in favor of LSP
"au filetype go nmap <silent> <leader>d <Plug>(go-def-tab)
nmap cu :GoInfo<CR>
"au filetype go nmap <leader>r :GoReferrers<CR>

" Control-P opens FZF finder that ignores .gitignore files
nnoremap <C-p> :GitFiles<CR>

" ========================
" Color Scheme
" ========================

syntax on
set t_Co=256
colorscheme monokai
hi Normal ctermbg=233  " darken background a bit

set colorcolumn=80
hi ColorColumn ctermbg=16

"setup highlighting for status line
hi User1 ctermfg=DarkBlue  ctermbg=LightMagenta

hi Pmenu ctermfg=231 ctermbg=17 cterm=NONE
hi PmenuSel ctermfg=236 ctermbg=186 cterm=NONE
hi PmenuSbar ctermfg=NONE ctermbg=NONE cterm=NONE
hi PmenuThumb ctermfg=NONE ctermbg=NONE cterm=NONE

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

