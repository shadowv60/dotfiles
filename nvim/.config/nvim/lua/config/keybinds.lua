-- 1. SET LEADER FIRST
vim.g.mapleader = " "

-- 2. NOW SET MAPPINGS
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>cd", "<cmd>Ex<CR>") -- Fixed the Ex error here
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

-- 3. THE SEARCH AND REPLACE MAPPING
-- This will now correctly use Space + r
vim.keymap.set("n", "<leader>r", ":%s/<C-r><C-w>/", { desc = "Search and replace word under cursor" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")
-- Move lines in Normal mode
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<CR>== ")
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<CR>== ")

-- Move lines in Visual mode (blocks of code)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
-- Buffer Navigation (IDE Style)
-- Use Tab to go to the next file, Shift+Tab to go back
vim.keymap.set('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })

-- Close the current file (without closing Neovim)
vim.keymap.set('n', '<leader>x', '<cmd>bdelete<CR>', { desc = 'Close current buffer' })

-- Window Navigation (Moving between Splits)
-- Instead of Ctrl+w + h/j/k/l, just use Ctrl + h/j/k/l
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
