return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        auto_install = true,
        ensure_installed = {
          "lua_ls", "clangd", "ts_ls", "html", "pyright",
          "rust_analyzer", "sqlls", "jsonls", "cssls", "svelte",
          "harper_ls", "graphql", "dockerls", "yamlls", "eslint",
          "vuels", "lemminx", "zls", "intelephense", "glsl_analyzer",
          "grammarly", "ast_grep", "asm_lsp"
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      -- existing servers
      local servers = {
        "ts_ls","html","pyright","lua_ls","rust_analyzer","clangd",
        "sqlls","jsonls","cssls","svelte","harper_ls","graphql",
        "dockerls","yamlls","eslint","vuels","lemminx","zls",
        "intelephense","glsl_analyzer","grammarly","ast_grep"
      }
      for _, name in ipairs(servers) do
        lspconfig[name].setup({ capabilities = capabilities })
      end

      -- GDScript (Godot’s built‑in LSP)
      lspconfig.gdscript.setup{
        cmd       = { "nc", "localhost", "6008" },
        filetypes = { "gd", "gdscript" },
        root_dir  = require("lspconfig.util").root_pattern("project.godot"),
        capabilities = capabilities,
        flags     = { debounce_text_changes = 150 },
      }

      vim.keymap.set("n", "K", vim.lsp.buf.hover)
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition)
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
    end,
  },
}

