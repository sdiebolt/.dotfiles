return {
    "ThePrimeagen/harpoon",

    branch = "harpoon2",

    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },

    opts = {},

    keys = function()
        local harpoon = require("harpoon")
        local conf = require("telescope.config").values

        local function toggle_telescope(harpoon_files)
            local make_finder = function()
                local paths = {}

                for _, item in ipairs(harpoon_files.items) do
                    table.insert(paths, item.value)
                end

                return require("telescope.finders").new_table({
                    results = paths,
                })
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = make_finder(),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
                attach_mappings = function(prompt_buffer_number, map)
                    map("i", "<C-d>", function()
                        local state = require("telescope.actions.state")
                        local selected_entry = state.get_selected_entry()
                        local current_picker = state.get_current_picker(prompt_buffer_number)

                        table.remove(harpoon_files.items, selected_entry.index)
                        current_picker:refresh(make_finder())
                    end)

                    return true
                end,
            })
                :find()
        end

        return {
            {
                "<leader>ht",
                function()
                    toggle_telescope(harpoon:list())
                end,
                desc = "Harpoon: telescope UI",
            },
            {
                "<leader>hd",
                function()
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Harpoon: default UI",
            },

            {
                "<leader>a",
                function()
                    harpoon:list():add()
                end,
                desc = "Harpoon: add",
            },

            {
                "<C-h>",
                function()
                    harpoon:list():select(1)
                end,
                desc = "Harpoon: select buffer 1"
            },

            {
                "<C-j>",
                function()
                    harpoon:list():select(2)
                end,
                desc = "Harpoon: select buffer 2"
            },

            {
                "<C-k>",
                function()
                    harpoon:list():select(3)
                end,
                desc = "Harpoon: select buffer 3"
            },

            {
                "<C-l>",
                function()
                    harpoon:list():select(4)
                end,
                desc = "Harpoon: select buffer 4"
            },

            {
                "<C-p>",
                function()
                    harpoon:list():prev()
                end,
                desc = "Harpoon: previous",
            },

            {
                "<C-n>",
                function()
                    harpoon:list():next()
                end,
                desc = "Harpoon: next",
            },
        }
    end,
}
