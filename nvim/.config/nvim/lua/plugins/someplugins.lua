return {
    -- Oil has been removed from here

    -- 3. Undotree
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        end
    },

    -- 4. Comment.nvim
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
}
