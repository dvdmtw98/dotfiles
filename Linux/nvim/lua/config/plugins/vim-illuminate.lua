return {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("illuminate").configure({
            providers = {
                "lsp",
                "treesitter",
                "regex",
            },
            delay = 200,
            filetypes_denylist = {
                "neo-tree",
                "neo-tree-popup",
                "fugitive",
                "alpha",
                "TelescopePrompt",
                "mason",
                "netrw",
            },
            min_count_to_highlight = 1,
            case_insensitive_regex = false,
        })
    end,
}
