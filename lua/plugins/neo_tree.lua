-- lua/plugins/neo-tree.lua
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      -- Auto‑close on file open
      event_handlers = {
        {
          event = "file_open_requested",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
      -- Sidebar layout
      window = {
        position = "right",  -- move to the right side
        width    = 25,       -- make it 25 columns wide
      },
      -- (other sections like filesystem, buffers, git_status…)
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)

      -- Keep it transparent after any colorscheme change
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.cmd [[
            highlight NormalFloat        guibg=NONE
            highlight FloatBorder        guibg=NONE
            highlight NeoTreeNormal      guibg=NONE
            highlight NeoTreeNormalNC    guibg=NONE
            highlight NeoTreeEndOfBuffer guibg=NONE
          ]]
        end,
      })
    end,
  },
}

