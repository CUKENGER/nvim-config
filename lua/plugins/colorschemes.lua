return {
	-- {
	-- 	"olimorris/onedarkpro.nvim",
	-- 	priority = 1000, -- Загружаем первым
	-- 	config = function()
	-- 		require("onedarkpro").setup({
	-- 			theme = "onedark_vivid", -- Варианты: onedark, onelight, onedark_vivid, onedark_dark
	-- 			styles = {
	-- 				comments = "italic", -- Стиль для комментариев
	-- 				keywords = "bold", -- Стиль для ключевых слов
	-- 				functions = "NONE", -- Без выделения функций
	-- 				variables = "NONE", -- Без выделения переменных
	-- 			},
	-- 			options = {
	-- 				-- transparency = true, -- Прозрачный фон
	-- 				cursorline = true, -- Подсветка текущей строки
	-- 				terminal_colors = true, -- Цвета для встроенного терминала
	-- 			},
	-- 			-- colors = { -- Кастомные цвета (опционально)
	-- 				-- bg = "#1F1F1F", -- Тёмный фон (можно убрать для transparency)
	-- 				-- fg = "#ABB2BF", -- Основной цвет текста
	-- 				-- gray = "#5C6370", -- Цвет комментариев
	-- 			-- },
	-- 			colors = {
	-- 				bg = "#282C34", -- Мягкий тёмный фон
	-- 				fg = "#ABB2BF", -- Цвет текста для контраста
	-- 				gray = "#5C6370", -- Цвет комментариев
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000,
		
		


		config = function()
			require("onedarkpro").setup({
				theme = "onedark_vivid", -- Можно попробовать "onedark_dark" для более тёмного варианта
				styles = {
					comments = "italic", -- Итальянский стиль для комментариев
					keywords = "bold", -- Жирный для ключевых слов
					functions = "italic", -- Курсив для функций, чтобы выделить их мягко
					-- variables = "NONE",
					strings = "italic", -- Курсив для строк, добавляет элегантности
				},
				options = {
					transparency = false, -- Можно включить для прозрачного фона
					cursorline = true, -- Подсветка текущей строки
					terminal_colors = true, -- Цвета для терминала
					-- highlight_inactive_windows = true, -- Подсветка неактивных окон
					section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				},
				colors = {
bg = "#1F1F1F",
					-- fg = "#D8DEE9", -- Светлый текст для контраста (Nord-inspired)
					-- gray = "#5C6370", -- Мягкий серый для комментариев
					-- red = "#E06C75", -- Яркий красный для ошибок и акцентов
					-- green = "#98C379", -- Зелёный для строк и успеха
					-- yellow = "#E5C07B", -- Тёплый жёлтый для предупреждений
					-- blue = "#61AFEF", -- Голубой для ключевых слов
					-- purple = "#C678DD", -- Фиолетовый для функций
					-- cursorline = "#35383F", -- Лёгкий фон для текущей строки
				},
				-- highlights = { -- Кастомные группы подсветки
				-- 	CursorLineNr = { fg = "#61AFEF", bg = "none", style = "bold" }, -- Номер текущей строки
				-- 	LineNr = { fg = "#5C6370", bg = "none" }, -- Номера строк
				-- 	NormalFloat = { bg = "#252932" }, -- Фон для плавающих окон
				-- 	Visual = { bg = "#3E4451" }, -- Подсветка выделения
				-- 	-- Pmenu = { bg = "#252932", fg = "#D8DEE9" }, -- Фон для автодополнения
				-- },
				sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			})
			vim.cmd("colorscheme onedark_vivid") -- Применяем тему
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true, -- Загружается по необходимости
	},
}
