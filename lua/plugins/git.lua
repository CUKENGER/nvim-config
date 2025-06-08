return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" }, -- Символ для добавленных строк
					change = { text = "~" }, -- Символ для измененных строк
					delete = { text = "_" }, -- Символ для удаленных строк
					topdelete = { text = "‾" }, -- Символ для удаленных строк сверху
					changedelete = { text = "~" }, -- Символ для измененных и удаленных строк
				},
				signcolumn = true, -- Включить столбец знаков
				numhl = false, -- Подсвечивать номера строк (опционально)
				linehl = false, -- Подсвечивать измененные строки (опционально)
				word_diff = false, -- Подсвечивать изменения внутри строки
				-- highlight_groups = {
				-- 	GitSignsAddLn = { guibg = "#d7ffaf" }, -- Зеленый фон для добавленных строк
				-- 	GitSignsChangeLn = { guibg = "#d7d7ff" }, -- Синий фон для измененных строк
				-- 	GitSignsDeleteLn = { guibg = "#ffafaf" }, -- Красный фон для удаленных строк
				-- },
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					-- Пример привязок клавиш для работы с Git
					vim.keymap.set("n", "]c", gs.next_hunk, { buffer = bufnr, desc = "Next Git Hunk" })
					vim.keymap.set("n", "[c", gs.prev_hunk, { buffer = bufnr, desc = "Previous Git Hunk" })
					vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { buffer = bufnr, desc = "Stage Hunk" })
					vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { buffer = bufnr, desc = "Reset Hunk" })
				end,
			})
		end,
	},
}
