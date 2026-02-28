return {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        require('telescope').setup({
            defaults = {
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '--hidden',
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    file_ignore_patterns = { "%.git/" }
                },
            },
        })

        require('telescope').load_extension('fzf')

        local builtin = require('telescope.builtin')

        -- 1. Search IN CURRENT FILE only
        vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Fuzzy search in current file' })

        -- 2. Search IN CURRENT DIRECTORY (where the active file is)
        vim.keymap.set('n', '<leader>sd', function()
            builtin.live_grep({
                cwd = vim.fn.expand('%:p:h')
            })
        end, { desc = 'Grep in current directory' })

        -- Your existing keymaps
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end
}
