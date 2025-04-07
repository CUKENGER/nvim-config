return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { show_start = false, show_end = false },
		},
		-- config = function()
		-- 	-- Задаём мягкий серый цвет для линий отступов
		-- 	-- vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#5A5F6A", nocombine = true })
		-- end,
	},
}
