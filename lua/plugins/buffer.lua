return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					diagnostics = "nvim_lsp", -- Подключение LSP-диагностики
					diagnostics_update_in_insert = false, -- Не обновлять диагностику в режиме вставки
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						-- Кастомный индикатор для отображения ошибок/предупреждений
						local s = ""
						for e, n in pairs(diagnostics_dict) do
							local sym = e == "error" and " " or (e == "warning" and " " or "ℹ ")
							s = s .. n .. sym
						end
						return s
					end,
					offsets = {
						{
							filetype = "neo-tree",
							text = "File Explorer",
							separator = true,
							padding = 1,
						},
					},
					show_buffer_close_icons = true, -- Показывать иконки закрытия буфера
					show_close_icon = false, -- Не показывать общую иконку закрытия
					separator_style = "thin", -- Стиль разделителя вкладок
				},
				highlights = {
					modified = {
						fg = "#ff5555", -- Цвет для измененных файлов
						bg = "#333333",
					},
					modified_selected = {
						fg = "#ff5555",
						bg = "#444444",
					},
					modified_visible = {
						fg = "#ff5555",
						bg = "#333333",
					},
				},
			})
		end,
	},
}
