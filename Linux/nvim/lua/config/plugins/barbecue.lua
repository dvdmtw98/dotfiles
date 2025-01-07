return {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        vim.opt.updatetime = 200

        require("barbecue").setup({
            create_autocmd = false,
            show_dirname = false,
            theme = "catppuccin",
        })

        vim.api.nvim_create_autocmd({
            "WinResized",
            "BufWinEnter",
            "CursorHold",
            "InsertLeave",
        }, {
            group = vim.api.nvim_create_augroup("barbecue.updater", {}),
            callback = function()
                require("barbecue.ui").update()
            end,
        })
    end,
}
