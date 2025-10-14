-- colorscheme & transparent bg
require("tokyonight").setup({
    style = "night",
    transparent = true,
})
vim.cmd [[colorscheme tokyonight]]

-- Generic formatting options
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Line numbering (relative in normal mode)
vim.opt.number = true
vim.opt.relativenumber = true
local group = vim.api.nvim_create_augroup("LineNumberToggle", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
    group = group,
    pattern = "*",
    callback = function() vim.opt.relativenumber = false end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
    group = group,
    pattern = "*",
    callback = function() vim.opt.relativenumber = true end,
})

-- General Movement
vim.keymap.set('n', '<C-w>', '<cmd>q<cr>', { desc = 'Close buffer' })
vim.keymap.set('n', '<C-s>', '<cmd>w<cr>', { desc = 'Save buffer' })

-- Neotree
vim.keymap.set('n', "\\", '<cmd>Neotree toggle<cr>', { desc = 'File Explorer' })

-- Tabs
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Tab Close' })
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'Tab New' })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
