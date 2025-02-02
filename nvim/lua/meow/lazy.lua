-- init.lua

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set log level to debug
vim.lsp.set_log_level("debug")

-- Configure Lazy.nvim with your plugins
require("lazy").setup({
    'folke/lazy.nvim',
    {
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    },
      {
        'williamboman/mason.nvim',
        config = function()
            require("mason").setup()
        end
    },
    'preservim/nerdtree',
    'kyazdani42/nvim-web-devicons',
    'nvim-telescope/telescope.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'neoclide/coc.nvim'
})

-- Set up Mason-lspconfig
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "ansiblels", "bashls" } -- Ensure ast_grep is installed
})

-- Set up nvim-cmp
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    -- Accept currently selected item with Enter
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})
-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Lua LSP setup
require('lspconfig')['lua_ls'].setup {
  capabilities = capabilities
}

-- Ansible LSP setup
require('lspconfig')['ansiblels'].setup {
  capabilities = capabilities,
  filetypes = { "yaml.ansible" }
}

-- Bash LSP setup
require('lspconfig')['bashls'].setup {
  capabilities = capabilities
}


