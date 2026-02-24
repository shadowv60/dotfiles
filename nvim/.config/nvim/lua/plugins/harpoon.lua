return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- Basic Harpoon UI Mappings
    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    
    -- Navigation
    vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end)

    -- Telescope Integration (The "Working List")
    vim.keymap.set("n", "<leader>fl", function()
        local conf = require("telescope.config").values
        local themes = require("telescope.themes")
        
        local file_paths = {}
        for _, item in ipairs(harpoon:list().items) do
            table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new(themes.get_ivy({ 
            prompt_title = "Harpoon Working List",
        }), {
            finder = require("telescope.finders").new_table({ 
                results = file_paths 
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
            -- This attachment ensures that pressing <Enter> actually opens the file
            attach_mappings = function(prompt_bufnr, map)
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")
                
                actions.select_default:replace(function()
                    local selection = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    vim.cmd("edit " .. selection[1])
                end)
                return true
            end,
        }):find()
    end, { desc = "Telescope: Open Harpoon list" })
  end
}
