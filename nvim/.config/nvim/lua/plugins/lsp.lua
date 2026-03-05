return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- 1. Setup Mason as usual
      require("mason").setup()
      
      local servers = { "lua_ls", "rust_analyzer", "pyright", "zls", "clangd", "yamlls" }
      
      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })

      -- 2. Setup Capabilities
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- 3. The New Way: Loop and use vim.lsp.config
      for _, lsp in ipairs(servers) do
        local config = {
          capabilities = capabilities,
        }

        -- Specific settings for Lua
        if lsp == "lua_ls" then
          config.settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          }
        end

        -- NEW SYNTAX FOR 0.11:
        -- Use vim.lsp.config to set the configuration
        -- Use vim.lsp.enable to actually start it
        vim.lsp.config(lsp, config)
        vim.lsp.enable(lsp)
      end

      -- 4. Diagnostic UI (Stays the same)
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded" },
      })
    end,
  },
}
