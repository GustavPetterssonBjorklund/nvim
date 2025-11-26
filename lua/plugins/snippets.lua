return {
    -- Snippet engine
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets", -- a big collection of community snippets
        },
        build = "make install_jsregexp",
        config = function()
            local ls = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            ls.config.set_config({
                history = true,
                updateevents = "TextChanged, TextChangedI",
                enable_autosnippets = true,
            })
        end
    },

    -- Completion engine
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip", -- snippet completions
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                },
                sources = cmp.config.sources({
                    { name = "copilot" },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },

    -- (Optional) Visual indicator for choice nodes
    {
        "windwp/nvim-ts-autotag",
        ft = { "html", "xml", "markdown" },
    },
}
