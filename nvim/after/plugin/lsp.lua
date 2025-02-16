-- lsp.lua

local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')

-- Setup `mason-lspconfig` to automatically install LSP servers
mason_lspconfig.setup({
  ensure_installed = { 'lua_ls', 'ansiblels', 'bashls', 'jdtls' }
})

-- Configuration for `nvim-cmp` capabilities with snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Optional: Define an `on_attach` function for keybindings
local on_attach = function(client, bufnr)
  -- Your custom keybindings
  local opts = { noremap=true, silent=true }
  -- Example: Go to definition
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- Add other keybindings as needed
end

-- Setup handlers for LSP servers
mason_lspconfig.setup_handlers({
  function(server_name)
    if server_name == 'jdtls' then
      -- Custom setup for `jdtls`

      -- Determine project root directory
      local root_markers = {'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}
      local root_dir = lspconfig.util.root_pattern(unpack(root_markers))(vim.fn.getcwd())
      local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

      -- Paths to JDTLS and configurations installed by Mason
      local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
      local launcher_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
      local config_dir = jdtls_path .. '/config_linux'

      -- Path to Java and Lombok (adjust paths according to your system)
      local lombok_jar = '/home/meow/lombok.jar'
      local java_home = '/usr/lib/jvm/java-17-openjdk-amd64'

      -- Command to start `jdtls`
      local cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-javaagent:' .. lombok_jar,
        '-Xbootclasspath/a:' .. lombok_jar,
        '-jar', launcher_jar,
        '-configuration', config_dir,
        '-data', workspace_dir,
      }

      -- Setup `jdtls`
      lspconfig.jdtls.setup{
        cmd = cmd,
        root_dir = root_dir,
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          java = {
            home = java_home,
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-17",
                  path = java_home,
                },
              },
            },
          },
        },
      }

    else
      -- Default setup for other servers
      lspconfig[server_name].setup{
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end
  end
})

