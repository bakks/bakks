""""""
" Python setup
" mkdir -p ~/.local/venv && cd ~/.local/venv
" python3 -m venv nvim
" cd nvim
" . ./bin/activate
" pip install pynvim neovim mypy ruff-lsp


" ========================
" Import Plugins
" ========================

" Debugging plugins: run the following commands
" Lazy install
" Lazy update
" TSUpdate
" COQdeps
" UpdateRemotePlugins
" Copilot status

lua << ENDLUA
plugins = {
    {'junegunn/fzf', build = './install --all'},
    'junegunn/fzf.vim',
    'kyazdani42/nvim-web-devicons',
    'kyazdani42/nvim-tree.lua',
    {'fatih/vim-go', ft = 'go', build = ':GoInstallBinaries'},
    {'pangloss/vim-javascript', ft = 'javascript'},
    {'mxw/vim-jsx', ft = {'javascript', 'javascript.jsx'}},
    {'prettier/vim-prettier', build = 'yarn install'},
    'neovim/nvim-lspconfig',
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    'mhinz/vim-startify',
    {'ms-jpq/coq_nvim', branch = 'coq'},
    {'ms-jpq/coq.artifacts', branch = 'artifacts'},
    {'github/copilot.vim', build = ':Copilot setup'},
    'airblade/vim-gitgutter',
    {'bakks/butterfish.nvim', dependencies = {'tpope/vim-commentary'},  dir='~/butterfish.nvim'},
    'scottmckendry/cyberdream.nvim',
    'sbdchd/neoformat',
    {'nvimtools/none-ls.nvim', dependencies = {'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig'}},
    'tpope/vim-fugitive',
    'almo7aya/openingh.nvim'
}

-- Bootstrap lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- load lazy plugin manager
require('lazy').setup(plugins)
ENDLUA

" ==========================
" Basic Neovim Configuration
" ==========================

lua << ENDLUA
-- Set options
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.laststatus = 2
vim.opt.backspace:append("indent")
vim.opt.backspace:append("eol")
vim.opt.backspace:append("start")
vim.opt.filetype.plugin = true
vim.opt.modeline = true
vim.opt.modelines = 10
vim.opt.timeout = true
vim.opt.timeoutlen = 400
vim.opt.ttimeoutlen = 400
vim.opt.autoread = true
vim.opt.backupcopy = "yes"
vim.opt.ignorecase = true

-- Define command for inserting new line at 80 characters
vim.cmd("command! -bar Doc set textwidth=80 | set fo+=to")

-- Set statusline
vim.opt.statusline = "%1*%<%F" ..   -- File+path
                     " %=" ..       -- Filler
                     "%1*%m%r%w" .. -- Modified? Readonly?
                     " %l/%L:%02c"  -- Row/total:column



ENDLUA

" ========================
" Basic Key Bindings
" ========================

lua << ENDLUA

-- Assumptions:
--   » is ctrl-s, mapped in terminal
--   ∫ is opt-b
--   µ is opt-m

function keybind(mode, lhs, rhs, desc, opts)
  default_opts = { noremap = true, silent = true }
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

function rpt(str, n)
  return string.rep(str, n)
end

vim.g.mapleader = "c"

-- dvorak movement mappings
keybind('n', 'h', '<Left>',            'h to left')
keybind('n', 't', '<Down>',            't to down')
keybind('n', 'n', '<Up>',              'n to up')
keybind('n', 's', '<Right>',           's to right')
keybind('v', 'h', '<Left>',            'h to left')
keybind('v', 't', '<Down>',            't to down')
keybind('v', 'n', '<Up>',              'n to up')
keybind('v', 's', '<Right>',           's to right')

-- control-letter during insert mode moves
keybind('i', '<C-h>', '<Left>',        'ctrl-h to left')
keybind('i', '<C-t>', '<Down>',        'ctrl-t to down')
keybind('i', '<C-n>', '<Up>',          'ctrl-n to up')
keybind('i', '»', '<Right>',           'ctrl-s to right')
keybind('i', '<C-e>', '<C-x><C-o>',    'ctrl-e to end of line')

keybind('n', 'U', ':redo<CR>',         'U to redo')
keybind('n', 'T', '/<CR>',             'T to search forward')
keybind('n', 'N', '?<CR>',             'N to search backward')

-- rapid movement
keybind('n', '<C-h>', rpt('<Left>', 14),  'ctrl-h to move left 14x')
keybind('n', '»',     rpt('<Right>', 14), 'ctrl-s to move right 14x')
keybind('n', '<C-t>', rpt('<Down>', 8),   'ctrl-t to move down 8x')
keybind('n', '<C-n>', rpt('<Up>', 8),     'ctrl-n to move up 8x')
keybind('v', '<C-h>', rpt('<Left>', 14),  'ctrl-h to move left 14x')
keybind('v', '»',     rpt('<Right>', 14), 'ctrl-s to move right 14x')
keybind('v', '<C-t>', rpt('<Down>', 8),   'ctrl-t to move down 8x')
keybind('v', '<C-n>', rpt('<Up>', 8),     'ctrl-n to move up 8x')

-- window movement
keybind('n', '∫', '<C-w>w',        'opt-b to next window')
keybind('n', 'µ', '<C-w>p',        'opt-m to previous window')

-- tab movement
keybind('n', 'B', 'gt',            'B to next tab')
keybind('n', 'M', 'gT',            'M to previous tab')

-- quickfix movement
keybind('n', '<M-t>', ':cn<CR>',   'M-t to next item')
keybind('n', '<M-n>', ':cp<CR>',   'M-n to previous item')
keybind('c', '<C-t>', ':cn<CR>',   'ctrl-t to next item')
keybind('c', '<C-n>', ':cp<CR>',   'ctrl-n to previous item')

-- other
keybind('n', 'j', ':0<CR>',       'j to top')
keybind('n', 'q', ':$<CR>',       'q to bottom')
keybind('n', 'm', 's',            'm to replace text')
keybind('v', 'm', 's',            'm to replace text')
keybind('n', 'k', ':w<CR>',       'k to write file')
keybind('n', 'K', ':wa<CR>',      'k to write all open buffers')
keybind('v', 'k', '<C-O>:w<CR>',  'k to write file')
keybind('n', '<C-r>', ':e!<CR>',  'ctrl-r to reload file')
keybind('n', '<C-e>', '$',        'ctrl-e to jump to end of line')
keybind('n', '<C-a>', '0',        'ctrl-a to jump to beginning of line')
keybind('n', 'Q', ':q<CR>',       'Q to quit')
keybind('n', 'e', '$J<Right>',    'e to delete trailing newline')
keybind('n', '-', ':%s/\\s\\+$//<CR>',
  '- to kill trailing whitespace')
keybind('n', ';', ':source ~/.config/nvim/init.vim<CR>',
  '; to reload vim config')


ENDLUA

nmap = :grep --exclude-dir=vendor --exclude-dir=node_modules --exclude-dir=".next" --exclude-dir="./webclient/static" -siIR "" .<Left><Left><Left>


" ========================
" Plugin Key Bindings
" ========================

lua << ENDLUA

-- butterfish.nvim
keybind('n', ',p', ':BFFilePrompt ',   ',p to prompt in a file')
keybind('v', ',p', ':BFFilePrompt ',   ',p to prompt in a file')
keybind('n', ',r', ':BFRewrite ',      ',r to rewrite a line')
keybind('v', ',r', ':BFRewrite ',      ',r to rewrite a block')
keybind('n', ',c', ':BFComment<CR>',   ',c to comment above a line')
keybind('v', ',c', ':BFComment<CR>',   ',c to comment above a block')
keybind('n', ',e', ':BFExplain<CR>',   ',e to explain a line')
keybind('v', ',e', ':BFExplain<CR>',   ',e to explain a block')
keybind('n', ',f', ':BFFix<CR>',       ',f to fix an LSP error')
keybind('n', ',i', ':BFImplement<CR>', ',i to implement based on preceding code')
keybind('n', ',d', ':BFEdit ',         ',d to edit a file at arbitrary locations')
keybind('n', ',h', ':BFHammer<CR>',    ',h to edit based on hammer.sh output')
keybind('n', ',q', ':BFQuestion ',     ',q to ask a question')
keybind('v', ',q', ':BFQuestion ',     ',q to ask a question about a block')

-- nvim-tree
keybind('n', 'P', ':Tree<CR>', 'P to toggle file tree')
keybind('v', 'P', ':Tree<CR>', 'P to toggle file tree')

function nvim_tree_keybinds(bufnr)
  local api = require('nvim-tree.api')

  api.config.mappings.default_on_attach(bufnr)

  -- these keybinds apply only within the nvim-tree window
  opt = { noremap = true, silent = true, buffer = bufnr }

  keybind('n', 'P', api.tree.close, 'Close', opt)
  keybind('n', '<Esc>', api.tree.close, 'Close', opt)
  keybind('n', 'O', api.node.open.no_window_picker, 'Open: No Window Picker', opt)
  keybind('n', 'o', api.node.open.tab, 'Open: New Tab', opt)
  keybind('n', '<CR>', api.node.open.tab, 'Open: New Tab', opt)
  keybind('n', '<C-t>', api.node.navigate.sibling.next, 'Next Sibling', opt)
  keybind('n', '<C-n>', api.node.navigate.parent, 'Parent Directory', opt)
end

-- LSP
keybind('n', 'ce', vim.diagnostic.open_float, 'ce to open floating error desc')
keybind('n', 'ct', vim.diagnostic.goto_next,  'ct to go to next error')
keybind('n', 'cn', vim.diagnostic.goto_prev,  'cn to go to previous error')

-- nvim-lspconfig

function lsp_keybinds(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  opt = { noremap = true, silent = true, buffer = bufnr }

  keybind('n', 'cd', vim.lsp.buf.definition, 'Go to definition', opt)
  keybind('n', 'cD', vim.lsp.buf.type_definition, 'Go to type definition', opt)
  keybind('n', 'ck', vim.lsp.buf.hover, 'Show hover information', opt)
  keybind('n', 'ci', vim.lsp.buf.implementation, 'Go to implementation', opt)
  keybind('n', 'cs', vim.lsp.buf.signature_help, 'Show signature help', opt)
  keybind('n', 'cR', vim.lsp.buf.rename, 'Rename symbol', opt)
  keybind('n', 'cca', vim.lsp.buf.code_action, 'Code action', opt)
  keybind('n', 'cr', vim.lsp.buf.references, 'Find references', opt)
end

-- vim-fugitive
keybind('n', 'cb', ':Git blame<CR>', 'Open git blame pane')

-- fzf
keybind('n', '<C-p>', ':GitFiles<CR>', 'Open FZF finder')

-- openingh.nvim
-- opens a line/range in github
keybind('n', 'cg', ':OpenInGHFileLines<CR>', 'Open line in github')
keybind('v', 'cg', ':OpenInGHFileLines<CR>', 'Open line in github')



ENDLUA

" ========================
" Plugin Configuration
" ========================

let g:fzf_action = { 'enter': 'tab split' }
let $FZF_DEFAULT_OPTS = '--bind ctrl-t:down,ctrl-n:up'
let g:jsx_ext_required = 0

lua << END

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "go", "gomod", "vim", "json", "javascript", "html", "make", "lua", "python", "terraform", "yaml", "toml", "markdown", "markdown_inline" },
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


vim.api.nvim_create_user_command('Tree', function()
  local api = require("nvim-tree.api")
  local global_cwd = vim.fn.getcwd(-1, -1)
  api.tree.toggle({find_file = true, path = global_cwd})
end, {})


require("nvim-tree").setup({
  on_attach = nvim_tree_keybinds,
  git = {
    enable = false,
  },
  view = {
    width = 36,
  },
})



local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- COQ (autocompletion) settings
vim.g.coq_settings = {
  auto_start = 'shut-up',

  completion = {
    always = false,
  },

  keymap = {
    jump_to_mark = '',
    recommended = false,
    manual_complete = 'ç',
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

local lspconfig = require('lspconfig')

lspconfig.gopls.setup(require('coq').lsp_ensure_capabilities({
  on_attach = lsp_keybinds,
  flags = lsp_flags,
}))

lspconfig.ts_ls.setup(require('coq').lsp_ensure_capabilities({
  on_attach = lsp_keybinds,
  flags = lsp_flags,
}))

lspconfig.html.setup(require('coq').lsp_ensure_capabilities({
  on_attach = lsp_keybinds,
  flags = lsp_flags,
}))

lspconfig.rust_analyzer.setup(require('coq').lsp_ensure_capabilities({
  on_attach = lsp_keybinds,
  flags = lsp_flags,
}))


-- Pyright LSP configuration

-- Path to the virtual environment
local venv_path = os.getenv('VIRTUAL_ENV')
if venv_path == nil then
  venv_path = os.getenv('HOME') .. '/.local/venv/nvim'
end

local on_attach = function(client, bufnr)
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
    lsp_keybinds(client, bufnr)
end

if venv_path == nil then
  lspconfig.pyright.setup(require('coq').lsp_ensure_capabilities({
    on_attach = lsp_keybinds,
    flags = lsp_flags,
  }))
else
  lspconfig.pyright.setup(require('coq').lsp_ensure_capabilities({
    settings = {
      pyright = {
        disableOrganizeImports = false,
      },
      python = {
        analysis = {
          autoImportCompletions = true,
          autoSearchPaths = true, -- Automatically add search paths from your Python environment
          diagnosticMode = "workspace", -- Perform diagnostics on files in your workspace
          useLibraryCodeForTypes = true, -- Use library implementations to extract type information
          typeCheckingMode = "basic", -- off, basic, strict
        },
        pythonPath = venv_path .. '/bin/python', -- Path to the Python interpreter within your virtual environment
      }
    },
    on_attach = lsp_keybinds,
    flags = lsp_flags,
  }))
end

extra_args = { "--line-length", "100" }

lspconfig.ruff.setup(require('coq').lsp_ensure_capabilities({
    on_attach = on_attach,
    flags = lsp_flags,
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = extra_args,
        }
    }
}))



-- Use null-ls.nvim to help configure LSP
local null_ls = require("null-ls")

-- if .isort.cfg exists, use it
-- Check if the current directory has a file with the given name
local function file_exists(filename)
  local f = io.open(filename, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

-- Check if the root directory has the ".isort.cfg" file and add extra arguments if it does
if file_exists(".isort.cfg") then
  table.insert(extra_args, "--settings-path")
  full_path = vim.fn.getcwd() .. "/.isort.cfg"
  table.insert(extra_args, full_path)
  print("Using .isort.cfg")
end

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black.with({
      extra_args = extra_args,
    }),
    null_ls.builtins.formatting.isort,
  },
})




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
local jumpfn = function(err, result, ctx, config)
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

vim.lsp.handlers["textDocument/definition"] = jumpfn
vim.lsp.handlers["textDocument/typeDefinition"] = jumpfn


-- Configure diagnostics
-- Turn off left bar signs
vim.diagnostic.config({ signs = false })

END


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

" let g:copilot_node_command = "/opt/homebrew/Cellar/node@16/16.20.2/bin/node"

nmap ll :Copilot panel<CR>


" git-gutter
" This is highlighting for git changes in a file

let g:gitgutter_enabled = 1
set signcolumn=no



" ========================
" Color Scheme
" ========================

lua << ENDLUA

color_overrides = {
  -- Highlight groups to override, adding new groups is also possible
  -- See `:help highlight-groups` for a list of highlight groups

  -- overall background
  Normal = { bg = '#101010' },
  -- vertical line on right side
  ColorColumn = { bg = '#000000' },
  -- status line
  User1 = { fg = '#d0d0d0', bg = '#005f87' },
  -- LSP floating box
  NormalFloat = { bg = '#101010' },
  FloatBorder = { fg = '#ff5ea0', bg = '#101010' },
  GitGutterAddLine = { bg = '#1b1b1b' },
  GitGutterChangeLine = { bg = '#202020' },
  GitGutterDeleteLine = { bg = 'none' },
  GitGutterChangeDeleteLine = { bg = 'none' },
  -- background for highlighted text
  Search = { bg = '#ff5ea0' }, -- pink
  IncSearch = { bg = '#ff5ea0' }, -- pink
  CurSearch = { bg = '#ff5ea0' }, -- pink
  Visual = { bg = '#ff5ea0' }, -- pink
  CursorLine = { bg = '#ff5ea0' }, -- pink
}

require("cyberdream").setup({
  italic_comments = true,
  theme = { highlights = color_overrides, },
})

-- Override LSP floating window config to add rounded border
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'rounded'
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.cmd [[syntax on]]
vim.cmd [[colorscheme cyberdream]]
vim.cmd [[set colorcolumn=80,100]]
ENDLUA


" ========================
" Re-Open files at old line
" ========================

" set working directory to git project root
" or directory of current file if not git project
" http://inlehmansterms.net/2014/09/04/sane-vim-working-directories/
function! SetProjectRoot()
  " if full path does not start with /, exit
  "  (i.e. if it's a relative path or a protocol:// URL)
  if expand("%:p:h") !~ '^/'
    return
  endif

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



lua << ENDLUA

package.loaded['butterfish'] = nil

-- butterfish.nvim config
-- https://github.com/bakks/butterfish.nvim
local butterfish = require('butterfish')
butterfish.active_color_group = "User1"
ENDLUA

" ========================
" Auto-Commands
" ========================

lua << ENDLUA
vim.cmd('autocmd BufWritePre *.rs silent Neoformat rustfmt')

-- Set specific options for file types
vim.cmd("autocmd FileType make setlocal noexpandtab")
vim.cmd("autocmd FileType python setlocal expandtab")
vim.cmd("autocmd FileType coffee setlocal noexpandtab")
vim.cmd("autocmd FileType php setlocal noexpandtab")

-- Set file type for specific file extension
vim.cmd("autocmd BufRead,BufNewFile *.g4 set filetype=antlr4")

-- autocmd to run :COQnow when opening filetypes with supported language servers
vim.cmd [[
  augroup COQnow
    autocmd!
    autocmd FileType go,python,javascript,typescript,tsx,rust :COQnow -s
  augroup END
]]

-- Create an autocmd group for Python file formatting and linting
vim.api.nvim_create_augroup('PythonAutoGroup', {})

-- Format Python files before saving
vim.api.nvim_create_autocmd("BufWritePre", {
  group = 'PythonAutoGroup',
  pattern = "*.py",
  callback = function()
    vim.lsp.buf.format({async = false})
  end,
})

-- Run ruff linting and fixing after saving Python files
vim.api.nvim_create_autocmd("BufWritePost", {
  group = 'PythonAutoGroup',
  pattern = "*.py",
  command = "silent! !ruff check --fix --ignore I001,I004 %",
})


ENDLUA

au BufRead,BufNewFile */mdx set filetype=markdown

autocmd VimEnter * GitGutterSignsDisable
autocmd VimEnter * GitGutterLineHighlightsEnable

" run Prettier before saving for these file types
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.railroad,*.html Prettier


" re-open files at old line
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif

autocmd BufRead *
  \ call FollowSymlink() |
  \ call SetProjectRoot()

lua << EOF
vim.lsp.set_log_level("debug")
EOF

