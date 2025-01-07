return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"meuter/lualine-so-fancy.nvim",
	},
	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin",
				globalstatus = false,
			    disabled_filetypes = {
				    statusline = {
                        "neo-tree",
					    "alfa",
					    "help",
					    "dapui_watches",
					    "dapui_breakpoints",
					    "dapui_scopes",
					    "dapui_console",
					    "dapui_stacks",
					    "dap-repl",
				    },
			    },
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
            extensions = { "neo-tree", "lazy" },
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "facy_branch", "facy_diff", "fancy_diagnostics" },
				lualine_c = {
					{ "filename", path = 1 },
				},
				lualine_x = {
					"fancy_searchcount",
					"fancy_lsp_servers",
                    "encoding",
					{
						"fileformat",
						symbols = {
							unix = "LF",
							dos = "CRLF",
							mac = "LF",
						},
					},
					"fancy_filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{ "filename", path = 1 },
				},
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			}
        })
	end,
}

