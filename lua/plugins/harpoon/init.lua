return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            local conf = require("telescope.config").values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require("telescope.pickers")
                    .new({}, {
                        prompt_title = "Harpoon",
                        finder = require("telescope.finders").new_table({
                            results = file_paths,
                        }),
                        previewer = conf.file_previewer({}),
                        sorter = conf.generic_sorter({}),
                    })
                    :find()

                local make_finder = function()
                    local paths = {}
                    for _, item in ipairs(harpoon_files.items) do
                        table.insert(paths, item.value)
                    end

                    return require("telescope.finders").new_table({
                        results = paths,
                    })
                end
                require("telescope.pickers")
                    .new({}, {
                        prompt_title = "Harpoon",
                        finder = make_finder(),
                        previewer = conf.file_previewer({}),
                        sorter = conf.generic_sorter({}),
                        attach_mappings = function(prompt_buffer_number, map)
                            map(
                                "i",
                                "<C-d>", -- this is the delete key by doing
                                function()
                                    local state = require("telescope.actions.state")
                                    local selected_entry = state.get_selected_entry()
                                    local current_picker = state.get_current_picker(prompt_buffer_number)

                                    harpoon:list():remove(selected_entry)
                                    current_picker:refresh(make_finder())
                                end
                            )

                            return true
                        end,
                    })
                    :find()
            end
            --Setup
            harpoon.setup()
            -- Key mappings
            vim.keymap.set("n", "<leader>a", function()
                harpoon:list():add()
                local plugin = "Harpoon"
                vim.notify("-> File added to harpoon", "info", { title = " " .. plugin, timeout = 10 })
            end)
            vim.keymap.set("n", "<C-e>", function()
                toggle_telescope(harpoon:list())
            end, { desc = "Open harpoon window" })

            vim.keymap.set("n", "<leader>h", function()
                harpoon:list():select(1)
            end)

            vim.keymap.set("n", "<leader>j", function()
                harpoon:list():select(2)
            end)

            vim.keymap.set("n", "<leader>k", function()
                harpoon:list():select(3)
            end)

            vim.keymap.set("n", "<leader>l", function()
                harpoon:list():select(4)
            end)

            -- Toggle previous & next buffers
            -- Usage:
            -- <C-S-P> meaning Ctrl+Shift+P to go to previous buffer
            vim.keymap.set("n", "<A-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)

            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
            vim.keymap.set("n", "<A-S-N>", function()
                harpoon:list():next()
            end)
        end,
    },
}
