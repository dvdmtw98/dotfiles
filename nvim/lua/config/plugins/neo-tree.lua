return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            enable_git_status = true,
            enable_modified_markers = true,
            enable_diagnostics = true,
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    never_show = {
                        ".DS_Store",
                        "thumbs.db",
                    },
                    follow_current_file = {
                        enabled = true,
                        leave_dirs_open = true,
                    },
                    hijack_netrw_behavior = "open_default"
                },
            },
        })

        vim.keymap.set("n", "<Leader>ee", "<cmd>Neotree left reveal<CR>", { desc = "Open File Explorer" })
        vim.keymap.set(
            "n",
            "<Leader>ef",
            "<cmd>Neotree float reveal<CR>",
            { desc = "Open floating File Explorer to current file" }
        )
        vim.keymap.set("n", "<Leader>ec", "<cmd>Neotree close<CR>", { desc = "Close File Explorer" })
    end,
}
