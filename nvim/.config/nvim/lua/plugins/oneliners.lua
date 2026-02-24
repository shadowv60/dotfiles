return {
  -- 1. The Completion Engine (The dropdown menu)
{
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip", -- Add this
    "saadparwaiz1/cmp_luasnip", -- And this
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- Add this
      }, {
        { name = 'buffer' },
        { name = 'path' },
      })
    })
  end
    },
  -- 2. Your other plugins
  {
    "brenoprata10/nvim-highlight-colors",
    config = function() require("nvim-highlight-colors").setup({}) end
  },
  {
    "nvim-orgmode/orgmode",
    config = function()
      require("orgmode").setup({
        org_agenda_files = "~/orgfiles/**/*",
        org_default_notes_file = "~/orgfiles/refile.org",
      })
    end
  }
}
