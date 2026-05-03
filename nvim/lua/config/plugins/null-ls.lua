return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.diagnostics.selene,
			},
		})

		vim.keymap.set("n", "<Leader>gf", vim.lsp.buf.format, { desc = "Format file" })
	end,
}
