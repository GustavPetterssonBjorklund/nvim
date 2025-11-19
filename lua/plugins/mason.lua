return {
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                "lua_ls",
                "pyright",
                "rust_analyzer",
                "clangd",
            },
            automatic_installation = true, -- auto-install missing LSPs
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)

            -- Auto-setup every installed server
            require("mason-lspconfig").setup_handlers({
                function(server)
                    require("lspconfig")[server].setup({})
                end,
            })
        end,
    },
}

