return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- Opt into the rewrite
    lazy = false,   -- Critical: The new version must load on startup
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      -- 1. Initialize (The new setup is intentionally minimal)
      ts.setup({})

      -- 2. Install your parsers
      -- This replaces the old 'ensure_installed' table
      ts.install({ 
        "lua", 
        "rust", 
        "python", 
        "zig",
        "vim",
        "vimdoc",
        "query" -- Recommended: helps with TS debugging/queries
      })

      -- 3. Enable Highlighting & Indentation
      -- Since 'highlight = {enable = true}' is gone, we use an autocmd
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local bufnr = args.buf
          -- Start Treesitter highlighting for the buffer
          pcall(vim.treesitter.start, bufnr)
          
          -- Enable Treesitter-based indentation
          vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  -- 4. Autotag Setup (Moved to its own plugin entry)
  {
    "windwp/nvim-ts-autotag",
    opts = {}, -- This automatically calls setup() with default settings
  },
}
