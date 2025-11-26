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
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "clangd",
      },
      automatic_installation = true,
    },
    config = function(_, opts)
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              completion = { callSnippet = "Replace" },
              diagnostics = { globals = { "vim" } },
              telemetry = { enable = false },
            },
          },
        },
        pyright = {},
        rust_analyzer = {},
        clangd = {},
      }

      local ensured = opts.ensure_installed or {}
      for server in pairs(servers) do
        if not vim.tbl_contains(ensured, server) then
          table.insert(ensured, server)
        end
      end
      opts.ensure_installed = ensured

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      local function on_attach(client, bufnr)
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc and ("LSP: " .. desc) or nil })
        end

        map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
        map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
        map("n", "gr", vim.lsp.buf.references, "Goto References")
        map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
        map("n", "<leader>lr", vim.lsp.buf.rename, "Rename Symbol")
        map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>lf", function() vim.lsp.buf.format({ async = false }) end, "Format Buffer")
        map("n", "<leader>ld", vim.diagnostic.open_float, "Line Diagnostics")
        map("n", "<leader>lq", vim.diagnostic.setloclist, "Diagnostics to loclist")
        map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")

        if client.supports_method("textDocument/inlayHint") then
          if vim.lsp.inlay_hint and type(vim.lsp.inlay_hint.enable) == "function" then
            vim.lsp.inlay_hint.enable(bufnr, true)
          elseif vim.lsp.buf.inlay_hint then
            pcall(vim.lsp.buf.inlay_hint, bufnr, true)
          end
        end
      end

      opts.handlers = {
        function(server_name)
          local server_opts = servers[server_name] or {}
          server_opts = vim.tbl_deep_extend("force", {
            capabilities = capabilities,
            on_attach = on_attach,
          }, server_opts)
          require("lspconfig")[server_name].setup(server_opts)
        end,
      }

      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup(opts)
    end,
  },
}
