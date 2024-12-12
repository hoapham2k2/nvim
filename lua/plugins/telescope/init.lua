return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = function()
                    vim.cmd("make")
                end,
            },
        },
        config = function()
            -- Setup
            require("telescope").setup({
                defaults = vim.tbl_extend("force", require("telescope.themes").get_ivy(), {
                    --- your own `default` options go here, e.g.:
                    path_display = {
                        truncate = 2,
                    },
                    mappings = {},
                }),
                pickers = {},
                extensions = {
                    fzf = {
                        override_generic_sorter = false,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })

            require("telescope").load_extension("fzf")

            -- Keymaps
            vim.keymap.set("n", "<leader>ff", function()
                require("telescope.builtin").find_files()
            end, {
                desc = "Find [F]iles",
                silent = true,
            })

            vim.keymap.set("n", "<leader>fg", function()
                require("telescope.builtin").live_grep()
            end, {
                desc = "Find [G]rep",
                silent = true,
            })

            vim.keymap.set("n", "<leader>fb", function()
                require("telescope.builtin").buffers()
            end, {
                desc = "Find [B]uffers",
                silent = true,
            })

            vim.keymap.set("n", "<leader>fh", function()
                require("telescope.builtin").help_tags()
            end, {
                desc = "Find [H]elp",
                silent = true,
            })

            require("plugins.telescope.multigrep").setup()
        end,
    },
}
