local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'jdtls'},
  handlers = {
    function(server_name)
      if server_name == 'jdtls' then
        local root_markers = {'pom.xml', 'gradlew', 'build.gradle'}
        local root_dir = require('lspconfig.util').root_pattern(unpack(root_markers))(vim.fn.getcwd())
        local workspace_folder = vim.fn.stdpath('data') .. '/site/java/workspace/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

        require('lspconfig').jdtls.setup {
          cmd = {
            'java', '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-Xms1g',
            '-Xmx2G',
            '-jar', vim.fn.glob('/home/meow/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar'),  -- Path to the launcher JAR
            '-configuration', '/home/meow/.local/share/nvim/mason/packages/jdtls/config_linux',  -- Path to the Linux config directory
            '-data', workspace_folder,
            '-javaagent:/home/meow/lombok.jar',  -- Lombok agent
            '-Xbootclasspath/a:/home/meow/lombok.jar',
          },
          root_dir = root_dir,
          settings = {
            java = {
              configuration = {
                javaagent = "/home/meow/lombok.jar",
                runtimes = {
                  {
                    name = "JavaSE-17",
                    path = "/usr/lib/jvm/java-17-openjdk-amd64",
                  }
                },
              },
            },
          },
          init_options = {
            bundles = { vim.fn.glob("/home/meow/lombok.jar") },
          },
        }
      else
        require('lspconfig')[server_name].setup{}
      end
    end,
  }
})

