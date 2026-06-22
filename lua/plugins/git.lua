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
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>gP", "<cmd>Octo pr list<cr>", desc = "GitHub PRs" },
      { "<leader>go", "<cmd>Octo<cr>", desc = "Octo actions" },
      { "<leader>gO", "<cmd>Octo pr browser<cr>", desc = "Open PR in browser" },
      { "<leader>gc", "<cmd>Octo comment add<cr>", desc = "Add PR comment" },
      { "<leader>gC", "<cmd>Octo pr checkout<cr>", desc = "Checkout PR" },
      { "<leader>gR", "<cmd>Octo review start<cr>", desc = "Start PR review" },
      { "<leader>gS", "<cmd>Octo review submit<cr>", desc = "Submit PR review" },
    },
    opts = {
      picker = "telescope",
      enable_builtin = true,
      default_remote = { "upstream", "origin" },
      default_merge_method = "squash",
      default_delete_branch = false,
    },
  },
}
