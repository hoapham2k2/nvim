return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            "BurntSushi/ripgrep",
        },
        config = function()
            local telescope = require("telescope")
            -- Setup
            telescope.setup({
                defaults = vim.tbl_extend("force", require("telescope.themes").get_ivy(), {
                    --- your own `default` options go here, e.g.:
                    path_display = {
                        truncate = 2, -- truncate all folders except the last 2
                    },
                    mappings = {},
                }),
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                    live_grep = {},
                    buffers = {
                        sort_lastused = true,
                        ignore_current_buffer = true,
                        show_all_buffers = true,
                    },
                    help_tags = {
                        hidden = true,
                    },
                },
                extensions = {
                    fzf = {
                        override_generic_sorter = false, -- override the generic sorter
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })

            telescope.load_extension("fzf")
            -- Keymaps
            vim.keymap.set("n", "<leader>ff", function()
                require("telescope.builtin").find_files()
            end, {
                desc = "Find [F]iles",
                silent = true,
            })

            vim.keymap.set("n", "<leader>fg", function()
                require("telescope.builtin").live_grep({
                    additional_args = function()
                        return { "--hidden", "--no-ignore-vcs" }
                    end,
                })
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
