vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
