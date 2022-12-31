lua << EOF
require("nvim-tree").setup({
  update_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
  renderer = {
    highlight_opened_files = "all",
    indent_markers = {
      enable = true
    },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = false,
        git = false,
      }
    }
  },
  view = {
    side = "right",
    mappings = {
      custom_only = false,
      list = {
        { key = "P", action = "close" },
        { key = "<Esc>", action = "close" },
        { key = "O", action = "edit_no_picker" },
        { key = "o", action = "tabnew" },
        { key = "<CR>", action = "tabnew" },
        { key = "<C-t>", action = "next_sibling" },
        { key = "<C-n>", action = "parent_node" },
      },
    },
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})
EOF

nnoremap <leader>P :NvimTreeToggle<CR>
