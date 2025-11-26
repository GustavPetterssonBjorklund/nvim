local opt = vim.opt

-- UI
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.fillchars = { eob = " " }

-- Tabs & indentation
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Splits & windows
opt.splitright = true
opt.splitbelow = true
opt.winblend = 0

-- Misc
opt.clipboard = "unnamedplus"
opt.updatetime = 250
opt.timeoutlen = 400
opt.undofile = true
opt.confirm = true
opt.list = true
opt.listchars = { tab = "»·", trail = "·", extends = "»", precedes = "«" }

-- Toggle relative numbers in insert mode
local number_group = vim.api.nvim_create_augroup("LineNumberToggle", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
    group = number_group,
    callback = function() opt.relativenumber = false end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
    group = number_group,
    callback = function() opt.relativenumber = true end,
})

-- Brief visual feedback when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank({ higroup = "Visual", timeout = 150 }) end,
})

-- Diagnostics
local diagnostic_signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(diagnostic_signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = false,
    float = { border = "rounded" },
})

-- General mappings
vim.keymap.set("n", "<C-w>", "<cmd>q<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save buffer" })
vim.keymap.set("n", "\\", "<cmd>Neotree toggle<cr>", { desc = "File Explorer" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Tab Close" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "Tab New" })
