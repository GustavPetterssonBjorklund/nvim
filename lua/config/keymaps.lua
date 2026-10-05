local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

map("n", "<leader>qq", function()
  require("config.session").quit_all()
end, { desc = "Quit all" })
map("n", "<leader>qs", function()
  require("config.session").restore({ notify = true })
end, { desc = "Restore session" })
map("n", "<leader>qS", function()
  require("config.session").save({ force = true, notify = true })
end, { desc = "Save session" })

vim.cmd([[
  cnoreabbrev <expr> qa getcmdtype() == ':' && getcmdline() == 'qa'
    \ ? 'lua require("config.session").quit_all()'
    \ : 'qa'
  cnoreabbrev <expr> qall getcmdtype() == ':' && getcmdline() == 'qall'
    \ ? 'lua require("config.session").quit_all()'
    \ : 'qall'
  cnoreabbrev <expr> quitall getcmdtype() == ':' && getcmdline() == 'quitall'
    \ ? 'lua require("config.session").quit_all()'
    \ : 'quitall'
]])
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Write" })
map("n", "<Esc>", "<cmd>nohlsearch<cr><Esc>", { desc = "Clear search highlight" })
map("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer keymaps" })
map("n", "<leader>fK", "<cmd>Cheatsheet<cr>", { desc = "Cheat sheet" })

map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down (centred)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up (centred)" })
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down", silent = true })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up", silent = true })
map("v", "<", "<gv", { desc = "Indent left (keep selection)" })
map("v", ">", ">gv", { desc = "Indent right (keep selection)" })

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

map("n", "<leader><Tab>n", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader><Tab>c", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader><Tab>o", "<cmd>tabonly<cr>", { desc = "Close other tabs" })
map("n", "<leader><Tab>[", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
map("n", "<leader><Tab>]", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader><Tab>f", "<cmd>tabfirst<cr>", { desc = "First tab" })
map("n", "<leader><Tab>l", "<cmd>tablast<cr>", { desc = "Last tab" })

map("n", "<leader>xL", "<cmd>lopen<cr>", { desc = "Location list" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix list" })

map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostics" })

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("n", "<leader>uw", function()
  vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle wrap" })
map("n", "<leader>un", function()
  local on = vim.wo.number or vim.wo.relativenumber
  vim.wo.number = not on
  vim.wo.relativenumber = not on
end, { desc = "Toggle line numbers" })
map("n", "<leader>ud", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics display" })
