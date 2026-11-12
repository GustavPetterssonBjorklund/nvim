return {
  {
    "lervag/vimtex",
    ft = { "tex", "bib" },
    init = function()
      vim.g.vimtex_mappings_prefix = "<leader>v"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_quickfix_mode = 0
      -- texlab provides completion and diagnostics; vimtex handles compile, view and motions.
      vim.g.vimtex_view_method = vim.fn.executable("zathura") == 1 and "zathura" or "general"
      vim.g.vimtex_syntax_enabled = 1
    end,
  },
}
