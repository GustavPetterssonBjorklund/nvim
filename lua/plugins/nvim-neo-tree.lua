return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      window = {
        width = 30,
        side = "left",
        auto_resize = true,
      },
    })
<<<<<<< HEAD
    vim.keymap.set('n', '\'', '<cmd>Neotree toggle<CR>')
=======
    vim.keymap.set('n', '\'', ':Neotree toggle<CR>', {})
>>>>>>> d1c438f132de46078ef22236df2982fa030e69e1
  end,
}
