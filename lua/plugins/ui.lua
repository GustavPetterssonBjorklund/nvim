return {
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    lazy = false,
    priority = 1000,
    opts = {
      contrast = "hard",
      transparent_mode = false,
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      vim.o.background = "dark"
      vim.cmd.colorscheme("gruvbox")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        component_separators = "",
        globalstatus = true,
        section_separators = "",
        theme = "gruvbox",
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        offsets = {
          { filetype = "neo-tree", text = "Explorer", text_align = "center" },
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    lazy = true,
    opts = {
      background_colour = "#282828",
      stages = "fade",
      timeout = 2500,
    },
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        "╔══════════════════════════════════════════════════════════════════════════════╗",
        "║                         NVIM COMMAND DECK                                  ║",
        "║                    leader = <Space>  ·  theme = gruvbox                    ║",
        "╚══════════════════════════════════════════════════════════════════════════════╝",
      }
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", "<cmd>Telescope find_files<cr>"),
        dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<cr>"),
        dashboard.button("g", "  Live grep", "<cmd>Telescope live_grep<cr>"),
        dashboard.button("s", "  Shortcut sheet", "<cmd>Cheatsheet<cr>"),
        dashboard.button("c", "  Edit config", "<cmd>edit ~/.config/nvim/init.lua<cr>"),
        dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
      }
      dashboard.section.footer.val = {
        "",
        "TOP SHORTCUTS",
        "  <leader>ff  Find files        <leader>fg  Live grep",
        "  <leader>e   Explorer          <leader>gg  LazyGit",
        "  gd          Definition        <leader>la  Code action",
        "  <leader>xx  Diagnostics       <leader>db  Breakpoint",
        "",
        "Press s or run :Cheatsheet for the full scrollable shortcut sheet.",
      }
      dashboard.opts.layout = {
        { type = "padding", val = 1 },
        dashboard.section.header,
        { type = "padding", val = 1 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }
      require("alpha").setup(dashboard.opts)
    end,
  },
}
