local M = {}

local function session_dir()
  return vim.fn.stdpath("state") .. "/sessions"
end

local function session_file()
  local cwd = vim.uv.cwd() or vim.fn.getcwd()
  return session_dir() .. "/" .. vim.fn.sha256(cwd) .. ".vim"
end

local function has_restorable_work()
  if vim.fn.tabpagenr("$") > 1 then
    return true
  end

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buflisted and vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) ~= "" then
      return true
    end
  end

  return false
end

local function can_auto_restore()
  return #vim.api.nvim_list_uis() > 0
    and vim.fn.argc(-1) == 0
    and vim.fn.exists("v:std_in") == 1
    and vim.v.std_in == 0
end

function M.save(opts)
  opts = opts or {}

  if not opts.force and not has_restorable_work() then
    return false
  end

  vim.fn.mkdir(session_dir(), "p")

  local ok, err = pcall(vim.cmd, "silent mksession! " .. vim.fn.fnameescape(session_file()))
  if not ok and opts.notify ~= false then
    vim.notify("Could not save session: " .. err, vim.log.levels.WARN)
  elseif ok and opts.notify then
    vim.notify("Session saved", vim.log.levels.INFO)
  end

  return ok
end

function M.restore(opts)
  opts = opts or {}

  if opts.auto and not can_auto_restore() then
    return false
  end

  local file = session_file()
  if vim.fn.filereadable(file) == 0 then
    if opts.notify then
      vim.notify("No session found for " .. vim.fn.getcwd(), vim.log.levels.INFO)
    end
    return false
  end

  local ok, err = pcall(vim.cmd, "silent source " .. vim.fn.fnameescape(file))
  if not ok then
    if opts.notify ~= false then
      vim.notify("Could not restore session: " .. err, vim.log.levels.WARN)
    end
    return false
  end

  if opts.notify ~= false then
    vim.notify("Session restored", vim.log.levels.INFO)
  end

  return true
end

function M.quit_all()
  local tabs = vim.fn.tabpagenr("$")

  if tabs > 1 then
    local choice = vim.fn.confirm(
      ("Quit Neovim with %d tabs open? Session will be saved."):format(tabs),
      "&Quit\n&Cancel",
      2
    )
    if choice ~= 1 then
      return
    end
  end

  M.save({ force = true })
  vim.cmd("confirm qall")
end

return M
