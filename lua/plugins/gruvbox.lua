return { 
  "ellisonleao/gruvbox.nvim",
  priority = 1000, 
  config = true, 
  opts = ...,
  config = function()
    require("gruvbox").setup({
        terminal_colors = true,
        contrast = "hard"
    })
    vim.cmd.colorscheme "gruvbox"
  end,
}
