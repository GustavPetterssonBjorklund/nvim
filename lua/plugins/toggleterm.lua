return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = 15,
            direction = "float", -- default: floating
            start_in_insert = true,
            shade_terminals = true,
            shading_factor = 2,
            persist_size = true,
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = "curved",
                winblend = 0,
            },
        })

        local toggle = require("toggleterm").toggle

        -- Floating terminal
        vim.keymap.set("n", "<C-\\>", function()
            require("toggleterm").toggle(1, 20, vim.o.shell, "float")
        end, { desc = "ToggleTerm Float" })


        -- Horizontal terminal
        vim.keymap.set("n", "<leader>h", function()
            toggle(2, 15, vim.o.shell, "horizontal")
        end, { desc = "ToggleTerm Horizontal" })

        -- Vertical terminal
        vim.keymap.set("n", "<leader>v", function()
            toggle(3, 50, vim.o.shell, "vertical")
        end, { desc = "ToggleTerm Vertical" })

        -- Quick close with <C-q> inside terminal
        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "term://*",
            callback = function(args)
                local opts = { buffer = args.buf, silent = true }
                vim.keymap.set("t", "<C-q>", [[<C-\><C-n><Cmd>close<CR>]], opts)
            end,
        })

        -- Lazygit terminal
        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",
            hidden = true,
            direction = "float",
            float_opts = { border = "curved" },
        })

        function _LAZYGIT_TOGGLE() lazygit:toggle() end

        vim.keymap.set("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
            { noremap = true, silent = true, desc = "Lazygit" })
    end,
}
