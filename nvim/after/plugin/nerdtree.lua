require('nvim-web-devicons').setup {
    default = true,
    dark = true
}
vim.api.nvim_set_keymap('n', '<space>x', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeShowHidden = 1

