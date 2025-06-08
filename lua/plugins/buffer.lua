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
					-- show_buffer_close_icons = true, -- Показывать иконки закрытия буфера
					-- show_close_icon = true, -- Не показывать общую иконку закрытия
					separator_style = "thin", -- Стиль разделителя вкладок
					always_show_bufferline = true, -- Показывать bufferline даже с одним буфером
					enforce_regular_tabs = true,
					-- Добавляем безопасное закрытие буфера
					close_command = function(bufnum)
						-- Проверяем количество буферов
						local buffers = vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))
						if buffers > 1 then
							vim.api.nvim_buf_delete(bufnum, { force = true })
						else
							-- Если это последний буфер, создаем пустой
							vim.cmd("enew")
						end
					end,
					-- Кастомное форматирование имени буфера
          name_formatter = function(buf)
            local name = buf.name
            local path = buf.path
            -- Проверяем, является ли файл index с любым расширением
            if name:match("^index%.") then
              -- Пробуем извлечь путь начиная с `features`
              local relative_path = path:match(".*/features/(.+)/index%.(.+)")
              if relative_path then
                -- Возвращаем путь вида `LoginForm/ui/index.tsx`
                return relative_path .. "/index." .. name:match("index%.(.+)")
              end
              -- Если `features` нет, берём последние две папки
              local parent_path = path:match(".*/([^/]+/[^/]+)/index%.(.+)")
              if parent_path then
                return parent_path .. "/index." .. name:match("index%.(.+)")
              end
              -- Если и это не удалось, берём одну папку
              local parent = path:match(".*/([^/]+)/index%.(.+)")
              if parent then
                return parent .. "/index." .. name:match("index%.(.+)")
              end
            end
            -- Для остальных файлов возвращаем только имя
            return name
          end,
					-- Включаем поддержку мыши
					mouse = {
						enabled = true,
						-- Определяем действие для крестика
						close = function(bufnum)
							local buffers = vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))
							if buffers > 1 then
								vim.api.nvim_buf_delete(bufnum, { force = true })
							else
								vim.cmd("enew")
							end
						end,
					},
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
