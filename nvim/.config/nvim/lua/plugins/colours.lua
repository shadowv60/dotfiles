-- Transparency should usually go in your options.lua, but keeping it here works too
local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

enable_transparency()

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        options = {
            theme = "auto", -- or your specific theme name
            component_separators = { left = '|', right = '|' },
            section_separators = { left = '', right = '' },
        },
        sections = {
            -- Adding the neotype component to the right side of the status bar
            lualine_x = {
                function()
                    -- Protective call in case neotype isn't loaded yet
                    local ok, neotype = pcall(require, "neotype.lualine")
                    return ok and neotype.component() or ""
                end,
                'encoding', 'fileformat', 'filetype'
            },
        }
    }
}
