return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		-- Настройка nvim-notify
		require("notify").setup({
			background_colour = "#000000", -- Устанавливаем чёрный фон
			stages = "fade_in_slide_out",
			timeout = 3000,
			max_width = 80,
		})
		-- Убедимся, что vim.notify использует nvim-notify
		vim.notify = require("notify")

		-- Настройка noice.nvim
		require("noice").setup({
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
			notify = {
				enabled = true,
			},
			messages = {
				enabled = true,
				view = "notify",
				view_error = "notify",
				view_warn = "notify",
			},
		})
	end,
}
