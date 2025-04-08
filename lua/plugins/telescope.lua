return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin  = require("telescope.builtin")
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fr', function()
        local old_text = vim.fn.input("Replace: ")
        local new_text = vim.fn.input("With: ")
        -- This command will run the substitution on each file in the quickfix list.
        vim.cmd("cfdo %s/" .. old_text .. "/" .. new_text .. "/gc | update")
      end, { desc = "Replace text in quickfix list" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}

