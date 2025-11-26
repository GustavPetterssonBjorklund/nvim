return {
    {
        "nvim-telescope/telescope.nvim",
        version = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function() return vim.fn.executable("make") == 1 end,
            },
        },
        keys = {
            { "<leader>tf", function() require("telescope.builtin").find_files() end, desc = "Telescope files" },
            { "<leader>tg", function() require("telescope.builtin").live_grep() end,  desc = "Telescope live grep" },
            { "<leader>tb", function() require("telescope.builtin").buffers() end,   desc = "Telescope buffers" },
            { "<leader>th", function() require("telescope.builtin").help_tags() end, desc = "Telescope help" },
            { "<leader>tr", function() require("telescope.builtin").resume() end,    desc = "Telescope resume" },
        },
        opts = function()
            local actions = require("telescope.actions")
            return {
                defaults = {
                    prompt_prefix = "  ",
                    selection_caret = " ",
                    sorting_strategy = "ascending",
                    layout_strategy = "flex",
                    layout_config = { prompt_position = "top" },
                    path_display = { "smart" },
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                            ["<Esc>"] = actions.close,
                        },
                        n = {
                            ["q"] = actions.close,
                        },
                    },
                },
                pickers = {
                    find_files = { hidden = true },
                    live_grep = {
                        additional_args = function() return { "--hidden", "--glob", "!.git/*" } end,
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            }
        end,
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)
            pcall(telescope.load_extension, "fzf")
        end,
    },
}
