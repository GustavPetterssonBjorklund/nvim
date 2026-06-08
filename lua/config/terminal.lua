local M = {}

local terminals = {}
local tmux_buf

local function terminal(name, opts)
  if not terminals[name] then
    local Terminal = require("toggleterm.terminal").Terminal
    terminals[name] = Terminal:new(vim.tbl_extend("force", { hidden = true }, opts))
  end

  return terminals[name]
end

local function valid_tmux_buf()
  return tmux_buf and vim.api.nvim_buf_is_valid(tmux_buf)
end

local function switch_to_previous_buffer()
  local alt = vim.fn.bufnr("#")
  if alt > 0 and alt ~= tmux_buf and vim.api.nvim_buf_is_valid(alt) then
    vim.api.nvim_win_set_buf(0, alt)
    return
  end

  vim.cmd("bprevious")
end

function M.toggle_tmux()
  if valid_tmux_buf() then
    if vim.api.nvim_get_current_buf() == tmux_buf then
      switch_to_previous_buffer()
    else
      vim.api.nvim_win_set_buf(0, tmux_buf)
      vim.cmd.startinsert()
    end

    return
  end

  tmux_buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_win_set_buf(0, tmux_buf)

  local buf = tmux_buf
  local job_id = vim.fn.termopen({ "tmux", "new-session", "-A", "-s", "nvim" }, {
    on_exit = function()
      if tmux_buf == buf then
        tmux_buf = nil
      end
    end,
  })

  if job_id <= 0 then
    tmux_buf = nil
    vim.notify("Failed to start tmux terminal", vim.log.levels.ERROR)
    return
  end

  pcall(vim.api.nvim_buf_set_name, tmux_buf, "Terminal")
  vim.bo[tmux_buf].bufhidden = "hide"
  vim.bo[tmux_buf].buflisted = true
  vim.cmd.startinsert()
end

function M.toggle_float()
  terminal("float", {
    direction = "float",
    display_name = "terminal",
  }):toggle()
end

function M.toggle_horizontal()
  terminal("horizontal", {
    direction = "horizontal",
    display_name = "terminal",
    size = 15,
  }):toggle()
end

function M.toggle_vertical()
  terminal("vertical", {
    direction = "vertical",
    display_name = "terminal",
    size = 80,
  }):toggle()
end

return M
