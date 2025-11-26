return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "night",
            transparent = true,
        },
        config = function(_, opts)
            local function apply_transparency()
                local groups = {
                    "Normal",
                    "NormalNC",
                    "NormalFloat",
                    "FloatBorder",
                    "Pmenu",
                    "PmenuSel",
                    "SignColumn",
                    "StatusLine",
                    "NeoTreeNormal",
                    "NeoTreeNormalNC",
                    "NeoTreeEndOfBuffer",
                }
                for _, group in ipairs(groups) do
                    vim.api.nvim_set_hl(0, group, { bg = "none" })
                end
            end

            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight")
            apply_transparency()

            vim.api.nvim_create_autocmd("ColorScheme", {
                group = vim.api.nvim_create_augroup("TokyonightTransparency", { clear = true }),
                callback = apply_transparency,
            })
        end,
    },
}
