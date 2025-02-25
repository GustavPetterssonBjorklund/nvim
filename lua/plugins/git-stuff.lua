return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    {
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim",         -- required
        "sindrets/diffview.nvim",        -- optional - Diff integration

        -- Only one of these is needed.
        "nvim-telescope/telescope.nvim", -- optional
        },
      config = true
    }
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.cmd [[
        nnoremap <leader>gs :Git<CR>
        nnoremap <leader>gc :Git commit<CR>
        nnoremap <leader>gp :Git push<CR>
        nnoremap <leader>gl :Git pull<CR>
        nnoremap <leader>gd :Gdiff<CR>
        nnoremap <leader>gb :Git blame<CR>
      ]]
    end,
  },
}
