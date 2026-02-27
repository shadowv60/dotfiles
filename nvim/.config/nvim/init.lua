require('config.options')
require('config.keybinds')
require('config.lazy')

-- Configure Gruvbox BEFORE setting the colorscheme
require("gruvbox").setup({
    transparent_mode = true,
})

vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
