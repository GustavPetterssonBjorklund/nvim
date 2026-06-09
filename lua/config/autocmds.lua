local group = vim.api.nvim_create_augroup("user_config", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank({ timeout = 180 })
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
  group = group,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "help", "man", "qf", "query", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, desc = "Close window" })
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = group,
  callback = function()
    require("config.session").save({ notify = false })
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  nested = true,
  callback = function()
    vim.schedule(function()
      require("config.session").restore({ auto = true, notify = false })
    end)
  end,
})
