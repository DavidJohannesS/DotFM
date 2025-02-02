vim.o.mouse = 'a';

require'nvim-tree'.setup {
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  hijack_netrw = false,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  view = {
    width = 42,
    side = 'left',
  },
  renderer = {
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
  open_on_tab = false,
  hijack_cursor = true,
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  -- Use on_attach to define custom key mappings
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')
    local opts = { noremap = true, silent = true, nowait = true, buffer = bufnr }

    -- Custom key mappings for nvim-tree
-- Mapping Enter key and left mouse click to open/edit action
vim.keymap.set('n', '<CR>',  api.node.open.edit, opts)
vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts)

    --vim.keymap.set('n', 'v', api.node.open.vertical, opts)
    --vim.keymap.set('n', 's', api.node.open.horizontal, opts)
    --vim.keymap.set('n', 't', api.node.open.tab, opts)
    vim.keymap.set('n', 'a', api.fs.create, opts)  -- Add mapping for create
    vim.keymap.set('n', 'd', api.fs.remove, opts)  -- Add mapping for create
    vim.keymap.set('n', 'r', api.fs.rename, opts)  -- Add mapping for rename
    vim.keymap.set('n', 'x', api.fs.cut, opts)     -- Add mapping for cut
    vim.keymap.set('n', 'p', api.fs.paste, opts)   -- Add mapping for paste
  end,
}

-- Function to change the top directory
function ChangeTopDir(dir)
  require'nvim-tree'.change_dir(dir)
end

-- Function to prompt user for directory and change top directory
function PromptAndChangeTopDir()
  local dir = vim.fn.input("Enter directory: ")
  require'nvim-tree'.change_dir(dir)
end

-- Global key binding to toggle nvim-tree
vim.api.nvim_set_keymap('n', '<leader>q', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Key binding to prompt user for directory
vim.api.nvim_set_keymap('n', '<leader>cd', ':lua PromptAndChangeTopDir()<CR>', { noremap = true, silent = true })

--vim.api.nvim_set_keymap('n', 't', ':lua require"nvim-tree.api".node.open.tab()<CR>', { noremap = true, silent = true }) 
--vim.api.nvim_set_keymap('n', 'v', ':lua require"nvim-tree.api".node.open.vertical()<CR>', { noremap = true, silent = true })
