return {
	-- 1. nvim-lspconfig (без особой конфигурации)
	{ "neovim/nvim-lspconfig" },

	-- 2. null-ls (с конфигурацией для форматирования на сохранение)
	-- {
	-- 	"jose-elias-alvarez/null-ls.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		local null_ls = require("null-ls")
	-- 		local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
	-- 		local event = "BufWritePre" -- или "BufWritePost"
	-- 		local async = event == "BufWritePost"
	--
	-- 		null_ls.setup({
	-- 			on_attach = function(client, bufnr)
	-- 				if client.supports_method("textDocument/formatting") then
	-- 					-- Форматирование по <Leader>lf
	-- 					vim.keymap.set("n", "<Leader>lf", function()
	-- 						vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
	-- 					end, { buffer = bufnr, desc = "[lsp] format" })
	--
	-- 					-- Форматирование при сохранении
	-- 					vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
	-- 					vim.api.nvim_create_autocmd(event, {
	-- 						buffer = bufnr,
	-- 						group = group,
	-- 						callback = function()
	-- 							vim.lsp.buf.format({ bufnr = bufnr, async = async })
	-- 						end,
	-- 						desc = "[lsp] format on save",
	-- 					})
	-- 				end
	--
	-- 				if client.supports_method("textDocument/rangeFormatting") then
	-- 					vim.keymap.set("x", "<Leader>f", function()
	-- 						vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
	-- 					end, { buffer = bufnr, desc = "[lsp] format" })
	-- 				end
	-- 			end,
	-- 		})
	-- 	end,
	-- },

	-- 3. none-ls (второй вариант null-ls с другими источниками)
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

	-- 4. conform.nvim
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					javascript = { "prettierd", "prettier", stop_after_first = true },
				},
			})

			-- Настройка горячей клавиши для форматирования
			vim.api.nvim_set_keymap(
				"n",
				"<leader>lf",
				"<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<CR>",
				{ noremap = true, silent = true, desc = "format" }
			)
		end,
	},

	-- 5. prettier.nvim (без конфигурации)
	{ "MunifTanjim/prettier.nvim" },
}
