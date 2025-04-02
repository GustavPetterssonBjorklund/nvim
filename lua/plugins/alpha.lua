return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Custom Header (optional)
    dashboard.section.header.val = {
      "󰋊 Welcome back, fireproof!",
      "",
    }

    -- Quick Actions (buttons)
    dashboard.section.buttons.val = {
      dashboard.button("e", "📄  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("SPC f f", "🔍  Find file", ":Telescope find_files <CR>"),
      dashboard.button("SPC f o", "🕘  Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("SPC f g", "󰱼  Grep text", ":Telescope live_grep <CR>"),
      dashboard.button("SPC s l", "💾  Restore last session", ":lua require('persistence').load({ last = true })<CR>"),
      dashboard.button("q", "🚪  Quit", ":qa<CR>"),
    }

    -- Footer message (optional)
    dashboard.section.footer.val = {
      "",
      "🔥 Code like nobody's watching.",
    }

    -- Final setup
    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.config)
  end,
}

