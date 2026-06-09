local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Write" })
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<leader>?", "<cmd>Cheatsheet<cr>", { desc = "Open cheat sheet" })

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location list" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix list" })

map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostics" })

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
