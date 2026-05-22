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
					types = "bold,italic",
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
					-- bg = "#1F1F1F",
					bg = "#16161E",
					fg = "#ABB2BF",
					gray = "#5C6370",

					red = "#E06C75",
					green = "#98C379",
					yellow = "#E5C07B",
					blue = "#61AFEF",
					purple = "#C678DD",
					cyan = "#56B6C2",
					orange = "#D19A66",
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

				highlights = {
					-- Основное
					CursorLineNr = { fg = "#61AFEF", style = "bold" },
					LineNr = { fg = "#4B5263" },
					CursorLine = { bg = "#252B37" },

					Visual = { bg = "#3E4452" },
					Search = { fg = "#000000", bg = "#E5C07B", style = "bold" },
					IncSearch = { fg = "#000000", bg = "#98C379" },

					NormalFloat = { bg = "#1F252F" },
					FloatBorder = { fg = "#61AFEF", bg = "#1F252F" },

					-- === Улучшенная подсветка для React/TS ===
					["@function"] = { fg = "#C678DD", style = "italic" }, -- определения функций
					["@function.call"] = { fg = "#C678DD", style = "italic" }, -- вызовы функций (самое важное!)
					["@function.builtin"] = { fg = "#61AFEF", style = "italic" }, -- встроенные use*

					-- Специально для React hooks (useSomething)
					["@function.call.react"] = { fg = "#C678DD", style = "bold,italic" },

					-- Альтернативные/дополнительные группы
					["@method"] = { fg = "#C678DD", style = "italic" },
					["@method.call"] = { fg = "#C678DD", style = "italic" },

					["@variable"] = { fg = "#ABB2BF" }, -- обычные переменные
					["@variable.parameter"] = { fg = "#E5C07B" }, -- параметры
					["@property"] = { fg = "#D19A66" },

					-- Ключевые слова и типы
					["@keyword"] = { fg = "#C678DD", style = "bold" },
					["@type"] = { fg = "#56B6C2", style = "bold,italic" },
					["@type.builtin"] = { fg = "#56B6C2", style = "bold" },

					-- Комментарии и строки
					["@comment"] = { fg = "#5C6370", style = "italic" },
					["@string"] = { fg = "#98C379", style = "italic" },

					-- Telescope и прочее
					TelescopePromptBorder = { fg = "#61AFEF" },
					TelescopeResultsBorder = { fg = "#61AFEF" },
					TelescopePreviewBorder = { fg = "#61AFEF" },
				},
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
