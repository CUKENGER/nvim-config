return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8", -- Фиксируем последнюю стабильную версию
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>fg", function()
				require("telescope.builtin").live_grep({
					-- сохраняем результаты в quickfix после выбора
					attach_mappings = function(_, map)
						map("i", "<C-q>", function(prompt_bufnr)
							require("telescope.actions").send_to_qflist(prompt_bufnr)
							require("telescope.actions").open_qflist(prompt_bufnr)
						end)
						map("n", "<C-q>", function(prompt_bufnr)
							require("telescope.actions").send_to_qflist(prompt_bufnr)
							require("telescope.actions").open_qflist(prompt_bufnr)
						end)
						return true
					end,
				})
			end, { desc = "Live grep -> quickfix" })

			-- Маппинги для Telescope
			vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
			-- vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
		end,
	},
	{
		"cljoly/telescope-repo.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
}
