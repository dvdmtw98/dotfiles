return {
    "goolord/alpha-nvim",
    config = function()
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                     ]],
            [[       ████ ██████           █████      ██                     ]],
            [[      ███████████             █████                             ]],
            [[      █████████ ███████████████████ ███   ███████████   ]],
            [[     █████████  ███    █████████████ █████ ██████████████   ]],
            [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
            [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
            [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
        }

        dashboard.section.buttons.val = {
            dashboard.button("e", " New File", "<cmd>ene<CR>"),
            dashboard.button("SPC ee", " File Explorer", "<cmd>Neotree<CR>"),
            dashboard.button("SPC ff", "󰱼 Find File", "<cmd>Telescope find_files<CR>"),
            dashboard.button("SPC fr", " Recent Files", "<cmd>Telescope oldfiles<CR>"),
            dashboard.button("SPC fg", " Find Word", "<cmd>Telescope live_grep<CR>"),
            -- dashboard.button("SPC wr", "󰁯 Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
            dashboard.button("q", " Quit NeoVim", "<cmd>qa<CR>"),
        }

        local function footer()
            -- Plugin Count and Load Time
            local lazy_stats = require("lazy").stats()
            local plugins_count = lazy_stats.loaded .. "/" .. lazy_stats.count
            local startup_time = (math.floor(lazy_stats.startuptime * 100 + 0.5) / 100)
            local footer_line1 = " " .. plugins_count .. " plugins loaded in " .. startup_time .. " ms"
            local line1_width = vim.fn.strdisplaywidth(footer_line1)

            -- Date and Time
            local datetime = "󰃭 " .. vim.fn.strftime("%d-%m-%Y") .. "  " .. vim.fn.strftime("%I:%M:%S")
            local footer_line2 = string.rep(" ", (line1_width - vim.fn.strdisplaywidth(datetime)) / 2) .. datetime

            -- Nvim Version
            local version = vim.version()
            local vim_version = " " .. version.major .. "." .. version.minor .. "." .. version.patch
            local footer_line3 = string.rep(" ", (line1_width - vim.fn.strdisplaywidth(vim_version)) / 2) .. vim_version

            return {
                " ",
                " ",
                footer_line1,
                footer_line2,
                footer_line3,
            }
        end

        dashboard.section.footer.val = footer()

        require("alpha").setup(dashboard.opts)

        vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
}
