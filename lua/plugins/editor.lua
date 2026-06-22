return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>b", group = "buffers" },
        { "<leader>d", group = "debug" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>l", group = "lsp" },
        { "<leader>q", group = "quit/session" },
        { "<leader>t", group = "terminal/tabs" },
        { "<leader>u", group = "ui" },
        { "<leader>x", group = "diagnostics" },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle explorer" },
      { "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Reveal in explorer" },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = { enabled = true },
      },
      window = {
        position = "right",
        width = 32,
      },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols" },
      { "<leader>xl", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references" },
    },
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo comments" },
    },
    opts = {},
  },
  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gb" },
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "echasnovski/mini.indentscope",
    event = "BufReadPost",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
  },
  {
    "lewis6991/satellite.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "akinsho/toggleterm.nvim",
    keys = {
      {
        "<leader>tt",
        function()
          require("config.terminal").toggle_tmux()
        end,
        desc = "Toggle tmux terminal buffer",
      },
      {
        "<leader>tf",
        function()
          require("config.terminal").toggle_float()
        end,
        desc = "Toggle floating terminal",
      },
      {
        "<leader>th",
        function()
          require("config.terminal").toggle_horizontal()
        end,
        desc = "Toggle horizontal terminal",
      },
      {
        "<leader>tv",
        function()
          require("config.terminal").toggle_vertical()
        end,
        desc = "Toggle vertical terminal",
      },
    },
    opts = {
      direction = "float",
      hide_numbers = true,
      insert_mappings = false,
      open_mapping = false,
      persist_mode = true,
      persist_size = true,
      shade_terminals = true,
      start_in_insert = true,
      float_opts = {
        border = "rounded",
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
        width = function()
          return math.floor(vim.o.columns * 0.85)
        end,
      },
    },
  },
}
