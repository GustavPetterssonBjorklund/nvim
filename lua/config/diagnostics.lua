local M = {
  enabled = false,
}

local function refresh()
  pcall(vim.cmd, "redrawstatus")
end

function M.status()
  if M.enabled then
    return nil
  end

  return "Diagnostics suppressed  <leader>xx"
end

function M.toggle()
  M.enabled = not M.enabled
  vim.cmd("Trouble diagnostics toggle")
  refresh()
end

vim.api.nvim_create_autocmd("User", {
  pattern = { "TroubleOpen", "TroubleClose" },
  callback = function(event)
    if event.match == "TroubleOpen" then
      M.enabled = true
    elseif event.match == "TroubleClose" then
      M.enabled = false
    end

    refresh()
  end,
})

return M
