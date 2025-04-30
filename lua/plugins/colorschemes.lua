return {
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Загружаем первым
		config = function()
			require("onedarkpro").setup({
				theme = "onedark_vivid", -- Варианты: onedark, onelight, onedark_vivid, onedark_dark
				styles = {
					comments = "italic", -- Стиль для комментариев
					keywords = "bold", -- Стиль для ключевых слов
					functions = "NONE", -- Без выделения функций
					variables = "NONE", -- Без выделения переменных
				},
				options = {
					transparency = true, -- Прозрачный фон
					cursorline = true, -- Подсветка текущей строки
					terminal_colors = true, -- Цвета для встроенного терминала
				},
				-- colors = { -- Кастомные цвета (опционально)
				-- 	bg = "#1E222A", -- Тёмный фон (можно убрать для transparency)
				-- 	fg = "#ABB2BF", -- Основной цвет текста
				-- 	gray = "#5C6370", -- Цвет комментариев
				-- },
			})
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true, -- Загружается по необходимости
	},
}
