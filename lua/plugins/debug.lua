return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "REPL" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    },
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local mason_registry = require("mason-registry")

      require("mason-nvim-dap").setup({
        automatic_installation = true,
        ensure_installed = { "codelldb", "js" },
      })
      require("nvim-dap-virtual-text").setup({})
      dapui.setup({})

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      local ok_codelldb, codelldb = pcall(mason_registry.get_package, "codelldb")
      if ok_codelldb and codelldb:is_installed() then
        local extension_path = codelldb:get_install_path() .. "/extension/"
        local adapter_path = extension_path .. "adapter/codelldb"
        local lib_path = extension_path .. "lldb/lib/liblldb.so"

        dap.adapters.codelldb = {
          type = "server",
          port = "${port}",
          executable = {
            command = adapter_path,
            args = { "--liblldb", lib_path, "--port", "${port}" },
          },
        }
        dap.configurations.rust = {
          {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
          },
        }
        dap.configurations.c = dap.configurations.rust
        dap.configurations.cpp = dap.configurations.rust
      end

      local ok_js, js = pcall(mason_registry.get_package, "js-debug-adapter")
      if ok_js and js:is_installed() then
        local js_path = js:get_install_path() .. "/js-debug/src/dapDebugServer.js"
        dap.adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = { js_path, "${port}" },
          },
        }
        for _, language in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
          dap.configurations[language] = {
            {
              name = "Launch file",
              type = "pwa-node",
              request = "launch",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
            {
              name = "Attach",
              type = "pwa-node",
              request = "attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end
    end,
  },
}
