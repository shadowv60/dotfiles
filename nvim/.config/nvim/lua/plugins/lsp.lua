return {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local servers = { 'lua_ls', 'rust_analyzer', 'pyright', 'zls', 'clangd', 'yamlls' }
        for _, lsp in ipairs(servers) do
            local config = { capabilities = capabilities }

            -- Specialized config for Lua to recognize the 'vim' global
            if lsp == 'lua_ls' then
                config.settings = {
                    Lua = {
                        diagnostics = { globals = { 'vim' } }
                    }
                }
            end

            vim.lsp.config(lsp, config)
            vim.lsp.enable(lsp)
        end
    end
}
