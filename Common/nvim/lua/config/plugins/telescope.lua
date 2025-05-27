return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("telescope").load_extension("fzf")

			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					path_display = { "smart" },
					file_ignore_patterns = {
						"node_modules/",
						"%.git/",
						"%.DS_Store$",
						"target/",
						"build/",
						"%.o$",
					},
				},
				pickers = {
					find_files = {
						hidden = true,
					},
					buffers = {
						show_all_buffers = true,
						sort_lastused = true,
						mappings = {
							i = {
								["<c-d>"] = actions.delete_buffer,
							},
							n = {
								["<c-d>"] = actions.delete_buffer,
							},
						},
					},
				},
			})

			vim.keymap.set("n", "<Leader>ff", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<Leader>fr", builtin.oldfiles, { desc = "Show Recent Files" })
			vim.keymap.set("n", "<Leader>fg", builtin.live_grep, { desc = "Grep File Content" })
			vim.keymap.set("n", "<Leader>fb", builtin.buffers, { desc = "View Buffers" })
			vim.keymap.set("n", "<Leader>fh", builtin.help_tags, { desc = "View Help Tags" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			require("telescope").load_extension("ui-select")
		end,
	},
}
