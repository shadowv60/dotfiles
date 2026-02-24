local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }) -- Also makes floats transparent
end

enable_transparency()

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        options = {
            -- Optional: Keeps the borders looking clean without background colors
            component_separators = { left = '|', right = '|'},
            section_separators = { left = '', right = ''},
        }
    }
}
