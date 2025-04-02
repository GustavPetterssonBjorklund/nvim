return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  opts = {
    terminal_colors = true,
    contrast = "hard",
    transparent_mode = true, -- optional if you want transparency
  },
  config = function(_, opts)
    require("gruvbox").setup(opts)
    vim.cmd.colorscheme("gruvbox")
  end,
}

