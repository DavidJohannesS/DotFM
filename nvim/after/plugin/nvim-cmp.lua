local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),  -- Navigate to the next item
    ['<C-p>'] = cmp.mapping.select_prev_item(),  -- Navigate to the previous item
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),  -- Accept currently selected item
    ['<C-e>'] = cmp.mapping.abort(),  -- Abort completion
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },  -- LSP completions
    { name = 'luasnip' },  -- Snippet completions
  }, {
    { name = 'buffer' },  -- Buffer word completions
  })
})

