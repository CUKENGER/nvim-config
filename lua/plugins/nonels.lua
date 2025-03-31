return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettierd.with({
						filetypes = {
							"css",
							"scss",
							"sass",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"jsx",
							"tsx",
						},
					}),
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.diagnostics.eslint,
					null_ls.builtins.formatting.prettier.with({
						filetypes = {
							"css",
							"scss",
							"sass",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"jsx",
							"tsx",
						},
					}),
				},
			})
		end,
	},
}
