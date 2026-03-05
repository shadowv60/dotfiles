return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this makes it load only when you start opening files
  opts = {
    -- directory where session files are saved
    dir = vim.fn.stdpath("state") .. "/sessions/", 
    options = { "buffers", "curdir", "tabpages", "winsize" },
  },
  keys = {
    -- Restore the session for the current directory
    { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
    -- Restore the last session (even if you're in a different folder)
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    -- Stop persistence (won't save the session on exit)
    { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
  },
}
