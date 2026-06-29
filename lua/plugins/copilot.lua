return {
  {
    "github/copilot.vim",
    cmd = "Copilot",
    event = "InsertEnter",
    init = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
    end,
    keys = {
      { "<leader>ca", "<cmd>Copilot auth<cr>", desc = "Copilot auth" },
      { "<leader>cp", "<cmd>Copilot panel<cr>", desc = "Copilot panel" },
      { "<leader>cs", "<cmd>Copilot status<cr>", desc = "Copilot status" },
    },
    config = function()
      vim.keymap.set("i", "<M-l>", 'copilot#Accept("\\<CR>")', {
        desc = "Accept Copilot suggestion",
        expr = true,
        replace_keycodes = false,
      })
    end,
  },
}
