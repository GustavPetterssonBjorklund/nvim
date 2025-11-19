return {
  {
    "mason-org/mason.nvim",
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
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "clangd",
      },
      -- new API: automatic_enable replaces setup_handlers/automatic_installation
      automatic_enable = true, -- this is the default, but explicit is nice
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      -- LSP settings are now done *outside* mason-lspconfig
      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({})
      lspconfig.pyright.setup({})
      lspconfig.rust_analyzer.setup({})
      lspconfig.clangd.setup({})
    end,
  },
}

