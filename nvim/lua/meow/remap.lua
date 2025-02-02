vim.g.mapleader = " "
--vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float(nil, { focusable = true })<CR>', {noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<space>q', ':Ex<CR>', {noremap = true, silent = true})
-- Map the function to a key combination
function OpenTerminalInSplit()
  local current_file_path = vim.fn.expand('%:p:h') -- Get the directory of the current file
  vim.cmd('vsplit') -- Open a vertical split
  vim.cmd('wincmd l') -- Move to the right split
  vim.cmd('terminal') -- Open terminal
  vim.cmd('lcd ' .. current_file_path) -- Change terminal directory to the current file's directory
  vim.cmd('startinsert') -- Enter insert mode in the terminal
end
vim.api.nvim_set_keymap('n', '<leader>ot', ':lua OpenTerminalInSplit()<CR>', { noremap = true, silent = true })
-- Function to show documentation using CoC.nvim
function ShowDocumentation()
    local filetype = vim.bo.filetype
    if vim.fn.index({'vim', 'help'}, filetype) >= 0 then
        vim.cmd('h ' .. vim.fn.expand('<cword>'))
    elseif vim.fn['coc#rpc#ready']() then
        vim.fn.CocActionAsync('doHover')
    else
        vim.cmd('!' .. vim.o.keywordprg .. ' ' .. vim.fn.expand('<cword>'))
    end
end

-- Map <Space>e to show documentation
vim.api.nvim_set_keymap('n', '<Space>e', ':lua ShowDocumentation()<CR>', { noremap = true, silent = true })

