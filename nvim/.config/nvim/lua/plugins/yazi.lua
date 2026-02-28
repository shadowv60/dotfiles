return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>y", "<cmd>Yazi<cr>", desc = "Open yazi" },
  },
  opts = {
    open_for_directories = false,
    -- Remove the 'yazi_command_args' line as it is not a valid option
  },
}
