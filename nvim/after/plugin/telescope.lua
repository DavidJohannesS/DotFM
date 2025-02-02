-- Add your existing key mappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>gq', builtin.find_files, {})
vim.keymap.set('n', '<leader>q', builtin.git_files, {})
vim.keymap.set('n', '<leader>hf', function() 

  builtin.find_files({cwd = '~/'}); 
  vim.keymap.set('n', '<leader>gq', function() builtin.find_files({ cwd = vim.fn.getcwd() }) end, { desc = 'Find files in current directory' })
end, {})

