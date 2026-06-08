return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "]h", function() require("gitsigns").nav_hunk("next") end, desc = "Next hunk" },
      { "[h", function() require("gitsigns").nav_hunk("prev") end, desc = "Previous hunk" },
      { "<leader>gb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Blame line" },
      { "<leader>gd", function() require("gitsigns").diffthis() end, desc = "Diff this" },
      { "<leader>gp", function() require("gitsigns").preview_hunk() end, desc = "Preview hunk" },
      { "<leader>gr", function() require("gitsigns").reset_hunk() end, desc = "Reset hunk" },
      { "<leader>gs", function() require("gitsigns").stage_hunk() end, desc = "Stage hunk" },
    },
    opts = {},
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
}
